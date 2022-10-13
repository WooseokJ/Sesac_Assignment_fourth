
import UIKit
import RealmSwift

class MigrationViewController: UIViewController {

    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. fileURL
        print("FileURL: \(localRealm.configuration.fileURL!)")
        
        //2. schemaVersion (현재쓰는 스키마가 몇버전인지 확인)
        do{
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!) // url에 들어가는 스키마 버전이 몇버전이냐
            print(version)
            
        } catch {
            print(error)
        }
        
        //3 test용으로 데이터 넣기
//        for i in 1...3 { // DB에 3개의 레코드(데이터) 넣기
//            let task = Todo(title: "할일 \(i)", importance: Int.random(in: 1...10))
//            try! localRealm.write{
//                localRealm.add(task)
//            }
//        }

    }
}
