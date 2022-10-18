
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
        for i in 1...3 { // DB에 3개의 레코드(데이터) 넣기
            let task = Todo(title: "할일 \(i)", importance: Int.random(in: 1...10))
            try! localRealm.write{
                localRealm.add(task)
            }
        }
        
        
        // realm list test(detailTodo)
//        for i in 1...10 {
//            let task = DetailTodo(detailTitle: "양파\(i)개 사기", favorite: true)
//            try! localRealm.write {
//                localRealm.add(task)
//            }
//        }
        
        // 특정 Todo 테이블에 DetailTodo 추가

//        guard let task = localRealm.objects(Todo.self).filter("title = '할일 2'").first else {return}
//        for _ in 1...10 {
//            let detail = DetailTodo(detailTitle: "프랭크 \(Int.random(in: 1...5))개 먹기", favorite: false)
//            try! localRealm.write {
//                task.detail.append(detail)
//            }
//        }
        
        // 특정 Todo 테이블 삭제
//        guard let task = localRealm.objects(Todo.self).filter("title = '할일 2'").first else {return}
//
//        try! localRealm.write({
//            localRealm.delete(task.detail)
//            localRealm.delete(task)
//        })
        
        
        // 특정 Todo Memo 추가
        guard let task = localRealm.objects(Todo.self).filter("title = '할일 1'").first else {return}
        let memo = Memo()
        memo.content = "이렇게 메모 내용 추가해봅니다.2222"
        memo.date = Date()
        try! localRealm.write({
            task.memo = memo
            
        })
        

    }
}
