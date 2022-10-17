
import Foundation
import RealmSwift

class Todo: Object {
    @Persisted var title: String
    @Persisted var importance: Int
    @Persisted(primaryKey: true) var objectid: ObjectId
    
    
    //    @Persisted var favorite: Double
//    @Persisted var userDescription: String
//    @Persisted var count: Int
    
    @Persisted var detail: List<DetailTodo> // detail에는 DetailTodo 테이블을 연동
    @Persisted var memo: Memo? // EmbeddedObject는 항상 optional
    
    convenience init(title: String, importance: Int) {
        self.init()
        self.title = title
        self.importance = importance
        
//        self.favorite = Double(importance)
    }
}


class DetailTodo: Object {
    @Persisted var detailTitle: String
    @Persisted var favorite: Bool
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    @Persisted var deadline: Date
    convenience init(detailTitle: String, favorite: Bool) {
        self.init()
        self.detailTitle = detailTitle
        self.favorite = favorite
    }
}

class Memo: EmbeddedObject {
    @Persisted var content: String
    @Persisted var date: Date
}

