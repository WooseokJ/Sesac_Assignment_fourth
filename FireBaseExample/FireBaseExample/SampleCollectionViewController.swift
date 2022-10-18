//
//  SampleCollectionViewController.swift
//  FireBaseExample
//
//  Created by useok on 2022/10/18.
//

import UIKit
import RealmSwift

class SampleCollectionViewController: UICollectionViewController {

    var tasks: Results<Todo>!
    let localRealm = try! Realm()
    
    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, Todo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // protocol
//        let tv = UITableView()
//        tv.delegate = self
//        tv.dataSource = self
        
        
        tasks = localRealm.objects(Todo.self)
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration) //UICollectionViewCompositionalLayout
        collectionView.collectionViewLayout = layout // UIcollectionviewLayout
        
        cellRegisteration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = cell.defaultContentConfiguration()
            content.image = itemIdentifier.importance < 2 ? UIImage(systemName: "person.fill") : UIImage(systemName: "person.2.fill")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개 세부항목"
            cell.contentConfiguration = content // UIcontentConfiguration
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = tasks[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: item)
    
        var test: fruit = apple() // 상위 클래스를 타입으로 선언해줘서
        test = banana()
        test = strawberry()
        test = melon() //구조체
//        test = ddd() //enum 안됨.
        
        var test2: food = apple()
        test2 = banana()
//        test2 = strawberry() //오류(food를 상속받지못해서)
//        test2 = melon() //오류
//        test2 = ddd() //오류
        
        return cell
    }
    
}

class food {
    
}

protocol fruit {
    
}

class apple: food,fruit{
    
}
class banana: food,fruit {
    
}

class strawberry:fruit {
    
}
struct melon:fruit {
    
}

enum ddd:fruit {
    
}
