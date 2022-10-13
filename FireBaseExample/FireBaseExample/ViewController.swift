
import UIKit
import FirebaseAnalytics

class ViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewcontroller viewwillAppear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Analytics.logEvent("share_image", parameters: [
//            "name": "고래밥", // userdefault or realm 에서 가져와 써도되고 String값을 지정해도된다
//          "full_text": "안녕",
//        ])
//
//        Analytics.setDefaultEventParameters([
//          "level_name": "Caverns01",
//          "level_difficulty": 4
//        ])
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {}
    //present
    @IBAction func profileButtonClicked(_ sender: UIButton) {
        present(ProfileViewControler(),animated: true)
    }
    //push
    @IBAction func settingButtonClicked(_ sender: UIButton) {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    
}


class ProfileViewControler: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("profileviewcontroller viewwillAppear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
    
}

class SettingViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("settingviewcontroller viewwillAppear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
    
}


extension UIViewController {
    var topViewController: UIViewController? { // get
        return self.topViewController(currentVC: self)
    }
    
    // 최상위 viewcontroller를 판단해주는 메서드
    func topViewController(currentVC: UIViewController) -> UIViewController {
        if let tabBarController = currentVC as? UITabBarController, let selectedVC = tabBarController.selectedViewController { //tabbar붙어있는경우
            return self.topViewController(currentVC: selectedVC)
        }
        else if let navigationController = currentVC as? UINavigationController, let visibleVC = navigationController.visibleViewController { //네비게이션 붙어있는경우
            return self.topViewController(currentVC: visibleVC)
        }
        else if let presentedViewController = currentVC.presentedViewController { // 프레젠트 붙어있는경우
            return self.topViewController(currentVC: presentedViewController)
        }
        else {
            return currentVC
        }
    }
}

extension UIViewController {
    // method swizzling , 모든 viewwillAppear를 chageviewWillAppear로 바꿔준다.
    class func swizzleMethod() {  // class와 static 의 차이는? 
        let origin = #selector(viewWillAppear) // 원래 메소드
        let chagned = #selector(changeViewWillAppear) // 바꾼 메소드
        
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin) ,
              let chageMethod = class_getInstanceMethod(UIViewController.self, chagned) else {
            print("함수 찾을수없거나 오류")
            return
        }
        method_exchangeImplementations(originMethod, chageMethod)
        
    }
        
    @objc func changeViewWillAppear() {
        print("change viewwillAppear succeed")
    }
    
}
