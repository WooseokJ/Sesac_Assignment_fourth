
import UIKit
import RxSwift
class ViewController: UIViewController { // 이게 프로필 화면이라 가정

//    let api = APIService()
    @IBOutlet weak var label: UILabel!
    
    let viewModel = ProfileViewModel()
    
    let disposeBag = DisposeBag()
    var testText = "jackiop"
    var testArray = Array(repeating: "B", count: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(testText[2])
        let phone = Phone()
        print(phone[2])
        print(phone.numbers[2]) // 위와동일
        
        
        bind()
        copyOnWrite()
        
    }
    func bind() {
        viewModel.profile // <single> , Syntax Sugar
            .withUnretained(self)
            .subscribe { (vc,val) in
                print(val.user.email)
                print(val.user.username)
                vc.label.text = val.user.email
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
            }
            .disposed(by: disposeBag)

        viewModel.getProfile()
    }
}


//MARK: copy on write - 값타입이여도 참조를 한다
/// 리소스 복제되었지만 수정되지않은

extension ViewController {
    
    
    /// 값타입 VS 참조타입(8회차)
    func copyOnWrite() {
        
        // 값타입(bool,String,symbol,int등)
        var test = "jack"
        address(&test) // 10
        var test2 = test //값타입
        address(&test2) //다른메모리 주소값   // 20
        test2 = "sesac"
        address(&test2) // 20
        
        print() //무시 // 이다음부터 새로운거
        /// 참조타입 (array, dict,set -> collection타입, class , func
        var array = Array(repeating: "A", count: 100)
        address(&array) //30
        
        var newArray = array // 실제로 복사안함, 원본을 복사함.
        address(&newArray) //30
        
        newArray[0] = "B"
        address(&array) // 기존의 30
        address(&newArray) // (B로 바뀌어서 새로운 주소값으로 나옴) 40
        
        
    }
    
    func address(_ value: UnsafeRawPointer) {
        let address = String(format: "%p", Int(bitPattern: value)) // value 주소값이 address에 들어감
        print(address)
    }
    
}

