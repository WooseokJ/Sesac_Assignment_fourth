
// 

import UIKit
import RxSwift
import RxCocoa

class SubjectViewController: UIViewController {
    
    @IBOutlet weak var newButton: UIBarButtonItem!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    let viewModel = SubjectViewModel()
    
    let publish = PublishSubject<Int>()  // Array<String> 과동일, 초기값이 없는 빈상태
    let behavior = BehaviorSubject(value: 100 )// 초기값 필수 써야한다(그래서 옵셔널처리필요없음).
    let replay = ReplaySubject<Int>.create(bufferSize: 3) // buffersize 작성된 이벤트만큼 메모리에서 이벤트를 가지고있다., 구독직후 한번에 이벤트를 전달.
    let async = AsyncSubject<Int>() // 거의안씀.
    // 블로그 찾아보다가 Variable이라는 키워드는 무시해도됨.
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        publishSubject()
//        behaviorSubject()
//        replaySubject()
//        asyncSubject()
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
        
//        viewModel.list
//            .bind(to: tableView.rx.items(cellIdentifier: "ContactCell", cellType: UITableViewCell.self)) { (row,element,cell) in
//                cell.textLabel?.text = "\(element.name)는 \(element.age)세 이고 폰번호는 \(element.number)입니다"
//            }
//            .disposed(by: disposeBag)
        
        let input = SubjectViewModel.Input(addTap: addButton.rx.tap, resetTap: resetButton.rx.tap, newTap: newButton.rx.tap, searchText: searchBar.rx.text)
        let output = viewModel.transform(input: input)
        
        viewModel.list // viewModel -> viewController(output) 로 전달. 
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "ContactCell", cellType: UITableViewCell.self)) { (row, element,cell) in
                cell.textLabel?.text = "\(element.name)는 \(element.age)세 이고 폰번호는 \(element.number)입니다"

            }
            .disposed(by: disposeBag)
        
        output.addTap.withUnretained(self)
            .subscribe { ( vc , _ ) in  // fetchData를 가져와서 보냄
                vc.viewModel.fetchData()
            }
            .disposed(by: disposeBag)
        
        
        output.resetTap
            .withUnretained(self)
            .subscribe { ( vc , _ ) in
                vc.viewModel.resetData()
            }
            .disposed(by: disposeBag)
        
        output.newTap // vc-> vm(input) 클로저구문보면 viewmodel 호출
            .withUnretained(self)
            .subscribe{ (vc , _) in
                vc.viewModel.newData()
            }
            .disposed(by: disposeBag)
        // VC -> VM(input)  클로저구문보면 value가 viewmodel로 들어감.
        output.searchText
            .withUnretained(self)
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) //1초 기다리는 코드
            .subscribe { (vc, value) in
                print("===\(value)")
                vc.viewModel.filterData(query: value)
            }
            .disposed(by: disposeBag)
        
        

            
    }
}

extension SubjectViewController {
    func publishSubject() {
        /// 요약
        ///초기값없는 빈상태, 구독이전  error/completed notification 이벤트 뮈시
        /// 구독이후 이벤트는 다 처리
        
        //구독전이라서 1,2는 안뜸.
        publish.onNext(1)
        publish.onNext(2)

        publish
            .subscribe { value in
                print("publish - \(value)")
            } onError: { error in
                print("publish - \(error)")
            } onCompleted: {
                print("publish completed")
            }  onDisposed: {
                print("publish disposed")
                print()
            }
            .disposed(by: disposeBag)

        // 구독을했으므로 3,4 뜸
        publish.onNext(3)
        publish.onNext(4) //publish.on(.next(4)) 로도 사용가능
        publish.onNext(5)
        publish.onCompleted() //작업이끝낫다, 그뒤 바로 dispose됨.
        publish.onNext(6) // 6은 출력이 안됨.
    }
    func behaviorSubject() {
        /// 요약
        // behavior는 초기값있어(구독전의 최근 값은 emit된다), 1,2를 주석처리하면 초기값100이 emit된다.
        
        //구독전이라서 1은 안뜸. 근데 2는 뜸
        behavior.onNext(1)
        behavior.onNext(2)

        behavior
            .subscribe { value in
                print("behavior - \(value)")
            } onError: { error in
                print("behavior - \(error)")
            } onCompleted: {
                print("behavior completed")
            }  onDisposed: {
                print("behavior disposed")
                print()
            }
            .disposed(by: disposeBag)

        // 구독을했으므로 3,4 뜸
        behavior.onNext(3)
        behavior.onNext(4) //behavior.on(.next(4)) 로도 사용가능
        behavior.onNext(5)
        behavior.onCompleted() //작업이끝낫다, 그뒤 바로 dispose됨.
        behavior.onNext(6) // 6은 출력이 안됨.
    }
    func replaySubject() {
        /// 요약
        // buffersize만큼 구독전에 개수가 보내진다.
        // 메모리에 buffer가 갖고있다. array,image를 갖고있다면
        
        //구독전 300,400,500 뜸(buffersize = 3일떄)
        replay.onNext(100)
        replay.onNext(200)
        replay.onNext(300)
        replay.onNext(400)
        replay.onNext(500)

        replay
            .subscribe { value in
                print("replay - \(value)")
            } onError: { error in
                print("replay - \(error)")
            } onCompleted: {
                print("replay completed")
            }  onDisposed: {
                print("replay disposed")
                print()
            }
            .disposed(by: disposeBag)

        // 구독을했으므로 3,4 뜸
        replay.onNext(3)
        replay.onNext(4) //replay.on(.next(4)) 로도 사용가능
        replay.onNext(5)
        replay.onCompleted() //작업이끝낫다, 그뒤 바로 dispose됨.
        replay.onNext(6) // 6은 출력이 안됨.
    }
    func asyncSubject() {
        /// 요약
        /// completed가 되기 직전에 실행 (최후의한마디느낌)
                
        //구독전이라서 1,2는 안뜸.
        async.onNext(100)
        async.onNext(200)
        async.onNext(300)
        async.onNext(400)
        async.onNext(500)

        async
            .subscribe { value in
                print("async - \(value)")
            } onError: { error in
                print("async - \(error)")
            } onCompleted: {
                print("async completed")
            }  onDisposed: {
                print("async disposed")
                print()
            }
            .disposed(by: disposeBag)

        // 구독을했으므로 3,4 뜸
        async.onNext(3)
        async.onNext(4) //async.on(.next(4)) 로도 사용가능
        async.onNext(5)

        async.onCompleted() //작업이끝낫다, 그뒤 바로 dispose됨.
        async.onNext(6) // 6은 출력이 안됨.
    }
}
