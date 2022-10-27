//
//  ViewController.swift
//  weekRxswift
//
//  Created by useok on 2022/10/24.
//

import UIKit
import RxCocoa // rxswift와 단짝
import RxSwift


class RxCocoaExampleViewController: UIViewController {
    
    @IBOutlet weak var simpleTableView: UITableView!
    @IBOutlet weak var simplePickerView: UIPickerView!
    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var simpleSwitch: UISwitch!
    
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var signEmail: UITextField!
    @IBOutlet weak var signName: UITextField!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    var disposeBag = DisposeBag()
    var nickname = Observable.just("Jack")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickname
            .bind(to: nicknameLabel.rx.text) //이미 받아온거 보여만줌.(Observer)
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//            self.nickname = "바뀜" // Observable은 전달만하지 값을 수정할순없다. , ob
            
        }
        
        setTableView()
        setPickerView()
        setSwitch()
        setSign()
        setOperator()
    }
    
    // 또는 disposebag()객체를 새롭게 넣어주거나,nil 할당.
    deinit { // VC deinit이 되면 알아서 dispose도 동작한다. 즉 deinit 만 잘처리하면 dispose는 신경쓰지않아도된다.
        print("ExCoCoaExapleVC")
    }
    
    func setOperator() {
        
        // 아래부분은 암기하지마라!
        let itemA = [3.0,4.0,5.0]
        let itemB = [1.0,2.0]
        
        Observable.just(itemA) // 가변매개변수를 하나만 쓸때는 이게더 효율.
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just complted")
            } onDisposed: { //성공하고 나면 리소스 정리를 한다.
                print("just onDisposed")
                print()
            }
            .disposed(by: disposeBag)
        
        Observable.of(itemA, itemB) //just는 하나만되지만 of는 두개도가능 (객체를 두개이상 올려놓을떄 just와 차이가발생)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of complted")
            } onDisposed: {
                print("of onDisposed")
                print()
            }
            .disposed(by: disposeBag)
        
        Observable.from(itemA) //sequence로 하나하나 전달.
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from complted")
            } onDisposed: {
                print("from onDisposed")
                print()
            }
            .disposed(by: disposeBag)
        /// repeat-while문,
        Observable.repeatElement("while") // repeatElement while문같은 기능   , 무한(infinite ) Observable Sequence
            .take(5)   // take로 개수제한을준다.     , 유한(finite) Observable Sequence
            .subscribe { value in
                print("유한한 repeat - \(value)")
            } onError: { error in
                print("유한한 repeat - \(error)")
            } onCompleted: {
                print("유한한 repeat complted")
            } onDisposed: {
                print("유한한 repeat onDisposed")
                print()
            }
            .disposed(by: disposeBag)
        /// 3초에하나씩 보냄
        
        let intervalObservale = Observable<Int>.interval(.seconds(3), scheduler: MainScheduler.instance) //3초에 하나씩 보내서 동작,  무한(infinite ) Observable Sequence -> 무한대로 next를 하므로 disposed하지않으므로
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - \(error)")
            } onCompleted: {
                print("repeat complted")
            } onDisposed: {
                print("repeat onDisposed")
                print()
            }
            .disposed(by: disposeBag)
        

        
        let intervalObservale2 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance) //1초에 하나씩 보내서 동작,  무한(infinite ) Observable Sequence
            .subscribe { value in
                print("interval - \(value)")
            } onError: { error in
                print("interval - \(error)")
            } onCompleted: {
                print("interval complted")
            } onDisposed: {
                print("interval onDisposed")
                print()
            }
            .disposed(by: disposeBag)
        
        // disposeBag: 리소스 해제 관리 방법 -
        //   -   1. 시퀀스 끝날떄,
        //   -   2. class deinit 자동해제 (bind같은 객체가 해당됨.)
        //   -   3. disposeBag 직접호출.-> dispose() 구독하는것마다 별도로 관리해줘야함.
        //   -   4. disposeBag을 새롭게 할당하거나 nil 전달.
        
        // dispose() 구독하는것 마다 별도로 관리!
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) { //10초후 종료
            self.disposeBag = DisposeBag() //한번에 리소스 정리
            
            //원래는 이렇게 해줘야한다.
            //            intervalObservale.dispose()
            //            intervalObservale2.dispose()
        }
    }
    
    func setSign() {
        // ex) textfield 1(observable),2(observable)  -> label(observer,bind) 에 표현
        Observable.combineLatest(signName.rx.text.orEmpty,signEmail.rx.text.orEmpty) { val1,val2 in // rx는 실시간으로 감지, orEmpty는 옵셔널바인딩처리(강제해제)가 필요없어짐, combineLatest는 둘중에 하나라도 값이바뀌면 최신화해준다.
            return "name: \(val1) , email: \(val2)"
        }
        .bind(to: simpleLabel.rx.text) // error, completed 되지않음.
        .disposed(by: disposeBag)
        
        signName // textfield
            .rx //reactive
            .text //String?
            .orEmpty //string
            .map{$0.count} //int
            .map {$0 > 4} //bool
            .bind(to: signButton.rx.isHidden) // signButton이 숨겨짐.
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 4}
            .bind(to: signButton.rx.isHidden) //글자수가 4 초과이면 signButton 숨겨짐
            .disposed(by: disposeBag)
        signButton.rx.tap
            .withUnretained(self) // 이거를 쓰면 클로저안에 순환참조([weak self] ) 안해줘도됨.
            .subscribe(onNext: { vc, _ in // vc가 [weak self]를 뜻함.
                vc.showAlert()
            })
            .disposed(by: disposeBag)
        
    }
    func showAlert() {
        let alert = UIAlertController(title: "하", message: "ㅇ", preferredStyle: .alert)
        let ok = UIAlertAction(title: "d", style: .cancel)
        alert.addAction(ok)
        present(alert,animated: true)
    }
    
    /// 테이블뷰 함수
    func setTableView() {
        simpleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let items = Observable.just([
            "First ",
            "Second ",
            "Third "
        ])
        
        items
            .bind(to: simpleTableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) , row: \(row)"
                return cell
            }
            .disposed(by: disposeBag)
        
        //        simpleTableView.rx.modelSelected(String.self).subscribe { value in  // next 이벤트
        //            print(value)
        //        } onError: {  error in // error
        //            print("error")
        //        } onCompleted: { // completed
        //            print("completed")
        //        } onDisposed: {
        //            print("disposed")
        //        }
        //        .disposed(by: disposeBag)
        
        simpleTableView.rx.modelSelected(String.self)
            .map{ data in
                "\(data)를 클릭햇습니다."
            }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    /// 데이터 피커뷰 함수
    func setPickerView() {
        let items = Observable.just([
            "영화",
            "애니메이션",
            "드라마"
        ])
        
        items
            .bind(to: simplePickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        simplePickerView.rx.modelSelected(String.self)
            .map {$0.description} // "\($0)" 도 가능
            .bind(to: simpleLabel.rx.text) // pickerview는 [string]배열이라 타입이 안맞아서 simpleLabel.rx.text는 String이 와야하므로 그래서 map으로 감싸준거
        //            .subscribe(onNext: { value in
        //                print(value)
        //            })
            .disposed(by: disposeBag)
    }
    /// 처음 시작시 스위치 꺼두기위한 메소드
    func setSwitch() {
        Observable.of(false) // just, of 둘다 결과는 동일
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
    
}

