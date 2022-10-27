//
//  ValidationViewController.swift
//  weekRxswift
//
//  Created by useok on 2022/10/27.
//

import UIKit
import RxSwift
import RxCocoa

class ValidationViewController: UIViewController {

    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var stepButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    let disposeBag = DisposeBag()
    let viewModel = ValidationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
//        observableVSSubject()
    }
    
    func bind() {
        // Stream == Sequence: 동의어!
        stepButton.rx.tap
            .subscribe { _ in
                print("next")
            } onError: { error in
                print("error")
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
//            .disposed(by: DisposeBag()) // 새로운 객체로 DisposeBag()를쓰면 새로운 disposeBag()으로 갈아끼워져서 !!, 수동으로 리소스 정리해주는것과동일, 이는 .dispose()랑동일/
    //  dispose리소스 정리(error, completed될떄 disposed된다) , deinit,
        
        
        viewModel.validText // 초기값: 닉네임은 최소 8글자
            .asDriver(onErrorJustReturn: " ") // drive에 error가 날순없지만 분기처리시 에러가 날수도있으므로 대응.
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        let validation =  nameTextField.rx.text // String?
                    .orEmpty // 옵셔널 제거 -> String
                    .map{$0.count >= 8} // 글자수판단 -> Bool
                    .share() // 내부적으로 구현된부분이 Subject,Relay 가된다.
                    
            ///1,2,3,4 같음.
            validation
            .bind(to: stepButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
//            /2
//            .bind(onNext: { val in
//                self.stepButton.rx.isEnabled = val
//                self.validationLabel.rx.isHidden = val
//            }).disposed(by: disposeBag)
//
//            /3
//            .subscribe(onNext: { val in
//                self.stepButton.isEnabled = val
//                self.validationLabel.isHidden = val
//            }).disposed(by: disposeBag)
//
//            /4
//            .subscribe { val in
//                self.stepButton.isEnabled = val
//                self.validationLabel.isHidden = val
//            }.disposed(by: disposeBag)
//
            validation
            .withUnretained(self)
            .bind{ (vc,val) in
                let color: UIColor = val ? .systemPink : .lightGray
                vc.stepButton.backgroundColor  = color
            }
            .disposed(by: disposeBag)

        
//        let testA = stepButton.rx.tap
//            .map{ "안녕하세요" }
//            .share()
//
//        testA.bind(to: validationLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        testA.bind(to: nameTextField.rx.text)
//            .disposed(by: disposeBag)
//
//        testA.bind(to: stepButton.rx.title())
//            .disposed(by: disposeBag)
        
        
//        let testA = stepButton.rx.tap
//            .map{ "안녕하세요" }
//            .asDriver(onErrorJustReturn: "") //share 와동일한 기능
//
//        testA
//            .drive(validationLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        testA
//            .drive(nameTextField.rx.text)
//            .disposed(by: disposeBag)
//
//        testA
//            .drive(stepButton.rx.title())
//            .disposed(by: disposeBag)
        
    }
    
    
    func observableVSSubject() {
        // just of from 이 Disposables안에 나열이되있음.
        // Observable을 만듬.
        let sampleInt = Observable<Int>.create{ observer in // 리소스를 3군데에 쓰고있다.! (그래서 같은값)
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
        sampleInt.subscribe{ val in
            print("sampleInt: \(val)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe{ val in
            print("sampleInt: \(val)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe{ val in
            print("sampleInt: \(val)")
        }
        .disposed(by: disposeBag)
            
        
        let subjectInt = BehaviorSubject(value: 0)
        subjectInt.onNext(Int.random(in: 1...100)) //구독전에 랜덤으로 뽑은걸 출력! , 리소스를 1군데 쓰고있다.(그래서 같은값)
        
        subjectInt.subscribe { val in
            print("subjectInt: \(val)")
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { val in
            print("subjectInt: \(val)")
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { val in
            print("subjectInt: \(val)")
        }
        .disposed(by: disposeBag)
        
        
        
        
    }

}
