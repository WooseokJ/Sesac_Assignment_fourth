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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setPickerView()
        setSwitch()
        setSign()
        setOperator()
    }
    func setOperator() {
        // 아래부분은 암기하지마라!
        var itemA = [3.0,4.0,5.0]
        var itemB = [1.0,2.0]
        
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
        Observable.repeatElement("while") // repeatElement while문같은 기능
            .take(5)   // take로 개수제한을준다.
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
        /// 3초에하나
        let intervalObservale = Observable<Int>.interval(.seconds(3), scheduler: MainScheduler.instance) //3초에 하나씩 보내서 동작
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
//            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { //10초후 종료
            intervalObservale.dispose()
        }
    }
    
    func setSign() {
        // ex) textfield 1(observable),2(observable)  -> label(observer,bind) 에 표현
        Observable.combineLatest(signName.rx.text.orEmpty,signEmail.rx.text.orEmpty) { val1,val2 in // rx는 실시간으로 감지, orEmpty는 옵셔널바인딩처리(강제해제)가 필요없어짐, combineLatest는 둘중에 하나라도 값이바뀌면 최신화해준다.
          return "name: \(val1) , email: \(val2)"
        }
        .bind(to: simpleLabel.rx.text)
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
            .subscribe { _ in
                self.showAlert()
            }
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

