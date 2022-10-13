//
//  AppDelegate.swift
//  FireBaseExample
//
//  Created by useok on 2022/10/05.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure() //파이어베이스에 xcode연결
        
        // 원격 알림 시스템에 앱 등록(꼭 didFinishLaunchingWithOptions에 적기)
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        // 메시지 대리자 설정(꼭 didFinishLaunchingWithOptions에 적기)
        Messaging.messaging().delegate = self
        
        // 현재 등록된 디바이스 토큰 가져오기(위치는 다른곳도 가능)
        //        Messaging.messaging().token { token, error in
        //          if let error = error {
        //            print("Error fetching FCM registration token: \(error)")
        //          } else if let token = token {
        //            print("FCM registration token: \(token)")
        //          }
        //        }
        
        UIViewController.swizzleMethod()
        // UIViewcontroller().swizzleMethod 는?
        
        
        
        aboutRealmMigration()
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // forground일떄 알림오게 해주는 메소드(로컬/푸시 동일)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // setting화면에 있다면 포그라운드 푸시 띄우지마라
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else {return} //topviewController는 VC에서 만든거
        if viewController is SettingViewController { // Setting 화면일떄 알림이 안옴.
            completionHandler([]) //알림이 안옴.
        } else { // Setting 화면이 아닐떄 알림이온다.
            // .banner, .list 는 ios14 이상부터사용가능( 그이전엔 .alert 이였다)
            completionHandler([.badge,.sound,.banner,.list])
        }
    }
    
    // 푸쉬클릭: 특정푸시 클릭하면 특정상세화면으로 화면전환 ex) 쿠팡 장바구니 담는 화면 전환
    // 위같은 상황에서 주의할떄 쿠팡장바구니를 화면전환하기위해 그앞에 화면들도 계층적으로 같이 보여줘야한다.
    
    // 유저가 푸시를 클릭시에만 실행
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("사용자가 푸시를 클릭함.")
        print(response.notification.request.content.body)
        print(response.notification.request.content.userInfo)
        let userInfo = response.notification.request.content.userInfo
        
        // 앱에서 사용할떄 ex) 가방광고알림이면 가방광고 상세페이지로 이동 시키고 , 화장품광고이면 화장품광고 상세페이지로 이동시킬떄 쓴다.
        if userInfo[AnyHashable("sesac")] as? String == "project" { //sesac이라는 키에 project라는 값이있다면?
            print("sesac project ===================================================================")
        } else {
            print("nothing==========================================================================")
        }
        
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else {return} //topviewController는 VC에서 만든거
        print(viewController)
        
        if viewController is ViewController { // is as , is: 인스턴스와 클래스가 같은지 판단할떄 사용, 홈화면일떄 setingViewController로 push된다.
            viewController.navigationController?.pushViewController(SettingViewController(), animated: true)
        } else if viewController is ProfileViewControler { // present로 올라와있기떄매 내려줌.
            viewController.dismiss(animated: true) {
                print("present 내려감.")
            }
        }
    }
}
extension AppDelegate: MessagingDelegate {
    // 토큰갱신 모니터링 (선택사항) : 토큰정보가 언제바뀔까?
    // 이걸안하면 ex) 앱은 설치되어있는데 회원탈퇴해도 알림이 계속온다
    // 현재 등록 토큰 가져오기
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

extension AppDelegate {
    
    func aboutRealmMigration() {
        //방법1
//        let config = Realm.Configuration(schemaVersion: 0, deleteRealmIfMigrationNeeded: true) // 새로운 스키마 버전 설정,  deleteRealmIfMigrationNeeded: 스키마 버전 0 부터 기존램이 지워지고 다시 Realm 0 생성
        
        //방법2
        let config = Realm.Configuration (
            schemaVersion: 6, // 새로운 버전 올릴떄마다 +1 해줘야함.(처음은 0 으로시작) 
            
            migrationBlock: { Migration, oldSchemaVersion in
                
                // 단계적으로 올라가야하며 , 칼럼 추가,삭제의경우에는 별도의 코드 필요없지만 흐름을 보기위해 명시적으로 쓰는편(이부분은 개인차이)
                if oldSchemaVersion < 1 { // realm version 0.   칼럼이 추가시  (어떤칼럼이 추가됬는지 주석으로 써준다)
                    
                }
                if oldSchemaVersion < 2 { // realm version 0,1에 대응. 칼럼이 삭제시 (어떤칼럼이 삭제됬는지 주석으로 써준다)

                }
                if oldSchemaVersion < 3 { // 칼럼명 변경시
                    Migration.renameProperty(onType: Todo.className(), from: "importance", to: "favorite")
                }
                if oldSchemaVersion < 4 { // 기존 칼럼두개의 데이터내용 합쳐서 새로운 칼럼에 넣기
                    Migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                        guard let new = newObject else {return}
                        guard let old = oldObject else {return}

                        new["userDescription"] = "안녕하세요 \(old["title"]!)의 중요도는 \(old["favorite"]!)입니다."
                    }
                }
                if oldSchemaVersion < 5 { // count = 100
                    Migration.enumerateObjects(ofType: Todo.className()) { _ , newObject in //파라미터 2개는 메서드안에 정의되있어서 명시적으로 써줘야함.
                        guard let new = newObject else {return}
                        new["count"] = 100
                    }
                }
                if oldSchemaVersion < 6 { // chageImportance 가 int -> double로 바꿀떄 ,
                    Migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in // 기존 칼럼두개의 데이터내용 합쳐서 새로운 칼럼에 넣기
                        guard let new = newObject else {return}
                        guard let old = oldObject else {return}

                        new["favorite"] = old["favorite"] ?? 0.0
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
    }
}
