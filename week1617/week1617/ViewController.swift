
import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var label: UILabel!
    let disposeBag = DisposeBag()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //1,2,3,4,5,6 동일한코드
        // 1
        button.rx.tap
            .withUnretained(self)
            .subscribe { (vc,_) in
                vc.label.text = "안녕1"
            }
            .disposed(by: disposeBag)
        // 2
        button.rx.tap
            .subscribe{[weak self] _ in
                self?.label.text = "안녕2"
            }
            .disposed(by: disposeBag)
        // 3. 네트워크 통신 ,파일다운로드 등 백그라운드 작업?
            
        button.rx.tap
//            .map{} //global
//            .map{} //global
//            .map{} //global
            .observe(on: MainScheduler.instance) // 데이터 시퀀스가 흘러가면서 main쓰레드로 바꿔줌.  이부분에서 main쓰레드에서 동작
//            .map{} //main
//            .map{} //main
//            .map{} //main
            .withUnretained(self)
            .subscribe{ ( vc , _ ) in
                vc.label.text = "안녕3"
            }
            .disposed(by: disposeBag)
        
        // 4. bind등장 : subscirbe, mainSchedular, errorX
        button.rx.tap
            .withUnretained(self)
            .bind { (vc,_) in // bind,subscribe둘다 구독하는것(bind는 다만 mainThread에서만 동작한다.그래서 error발생을 안함. )
                vc.label.text = "안녕4"
            }
            .disposed(by: disposeBag)
        
        // 5 . operator 데이터의 stream 조작
        button.rx.tap
            .map { "안녕5" }
            .bind(to: label.rx.text )
            .disposed(by: disposeBag)
        
        // 6. driver traits: bind + stream이 공유될수있다.(리소스 낭비를 방지할수있다.)
        button.rx.tap
            .map{"안녕6"}
            .asDriver(onErrorJustReturn: "") //에러발생시 어떤 키워드쓸래? 할떄 사용 , 보통은 빈 문자열("") 로 둔다.
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        
        
        
        
    }
  
    
        
        
    
    
    
    
}
