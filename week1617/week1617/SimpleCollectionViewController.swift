//
//  SimpleCollectionViewController.swift
//  SeSacWeek1617
//
//  Created by useok on 2022/10/18.
//

import UIKit

class User {
    let name: String
    let age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


class SimpleCollectionViewController: UICollectionViewController {

    // 1. CellRegisteration 선언
    var user = [
        User(name: "뽀",age: 1),
        User(name: "뽀뽀",age:2),
        User(name: "뽀뽀뽀",age:3),
        User(name: "뽀뽀뽀뽀",age:4)
    ]
    
    var list = ["A","B","C","D"]
     
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell,User>! // User은 user가 item이 User이라서 , User대신 String쓰는경우는 list가 item 이 String이라서, cell은 우리가생각하는 UIcollectionviewCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.register(UICollectionView.self, forCellWithReuseIdentifier: "") // 필요없음
        
        // 14+ 컬렉션뷰를 테이블뷰 스타일 처럼 사용 가능(그게 List configuration)
        // list configuration을 가져옴.
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped) // ,plan,.insetGoroup 자주사용
        configuration.showsSeparators = false // separators 구분선 사라짐(위아래 셀의 간격이 사라짐)
        configuration.backgroundColor = .brown //셀이아닌 셀 밖에 배경색이 바뀜.
        
        //
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout
        
        // 2. CellRegisteration 셀 등록
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in // 어떤 collectionviewCell 쓸거냐?, indexPath, itemIdentifier(item에 identifier넣음)
//            var content = cell.defaultContentConfiguration() // secondaryText가 아래로 붙음
            var content = UIListContentConfiguration.valueCell() // cell.defaultContentConfiguration(),   secondaryText가 옆으로 붙음(text글자가 길어지면 아래로 붙음)
            content.secondaryText = "\(itemIdentifier.age)"
            
            content.text = "\(itemIdentifier.name) 추가추가추가추가추가추가123412341234"
            content.prefersSideBySideTextAndSecondaryText = false // 텍스트가 밑으로감(글자수 적어도)
            content.textToSecondaryTextVerticalPadding = 20 //
            
            
            content.textProperties.color = .red //글자 색상
            
//            content.image = indexPath.item < 2 ? UIImage(systemName: "person.fill") : UIImage(systemName: "star")
            content.image = itemIdentifier.age < 2 ? UIImage(systemName: "person.fill") : UIImage(systemName: "star")

            content.imageProperties.tintColor = .yellow //이미지색상변경
            cell.backgroundConfiguration?.backgroundColor = .green // 셀 백그라운드 칼러
            
            cell.contentConfiguration = content
        }
        
        

    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.count
    }
    
    // 3. CellRegisteration 호출
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = user[indexPath.item]
        // cell타입,item타입 두개의 타입이 들어간다.
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        return cell
    }

    
}
