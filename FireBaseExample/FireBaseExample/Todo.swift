
import Foundation
import RealmSwift

class Todo: Object {
    @Persisted var title: String
    @Persisted var favorite: Double
    @Persisted(primaryKey: true) var objectid: ObjectId
    @Persisted var userDescription: String
    @Persisted var count: Int
    convenience init(title: String, importance: Int) {
        self.init()
        self.title = title
        self.favorite = Double(importance)
    }
}
