//
//  SimpleCollectionViewController.swift
//  SeSacWeek1617
//
//  Created by useok on 2022/10/18.
//

import UIKit

struct User: Hashable { //class로 바꾸면
    let id = UUID().uuidString // Hashable
    let name: String // Hashable(키로서 사용할수있다. , 그리고 
    let age: Int //Hashable
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


class SimpleCollectionViewController: UICollectionViewController {

    //MARK: 1. CellRegisteration 선언
    var user = [
        User(name: "뽀",age: 1),
        User(name: "뽀뽀",age:2),
        User(name: "뽀뽀뽀",age:3),
        User(name: "뽀뽀뽀뽀",age:4)
    ]
    
    var list = ["A","B","C","D"]
     // UICollectionViewListCell은 UIcollectionviewCell에 상속받음.
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell,User>! // User은 user가 item이 User이라서 , User대신 String쓰는경우는 list가 item 이 String이라서, cell은 우리가생각하는 UIcollectionviewCell
    var dataSource: UICollectionViewDiffableDataSource<Int,User>!  // Int는 색션의항목 ,list(모델의타입), <색션,데이터정보>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createlayout()
        
        
        //MARK: 2. CellRegisteration 셀 등록
        // register 단계대신 이거해줌.
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in // 어떤 collectionviewCell 쓸거냐?, indexPath, itemIdentifier(item에 identifier넣음)
//            var content = cell.defaultContentConfiguration() // secondaryText가 아래로 붙음
            var content = UIListContentConfiguration.valueCell() //  secondaryText가 옆으로 붙음(text글자가 길어지면 아래로 붙음)
            content.secondaryText = "\(itemIdentifier.age)"
            
            content.text = "\(itemIdentifier.name) 추가추가추가추가추가추가123412341234"
            content.prefersSideBySideTextAndSecondaryText = false // 텍스트가 밑으로감(글자수 적어도)
            content.textToSecondaryTextVerticalPadding = 20 //
            content.textProperties.color = .red //글자 색상
            content.image = indexPath.item < 2 ? UIImage(systemName: "person.fill") : UIImage(systemName: "star")
            
            if indexPath.item < 1 {
                content.imageProperties.tintColor = .blue
            } else {
                content.imageProperties.tintColor = .yellow // 이미지색상변경
            }
            cell.backgroundConfiguration?.backgroundColor = .green // 셀 백그라운드 칼러
            print("setup")
            cell.contentConfiguration = content
            
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .cyan
            cell.backgroundConfiguration = backgroundConfig
        }
//
//        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: itemIdentifier) // indexPath, itemIdentifier 둘다 이용해서 cell에 접근가능
//            return cell
//        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.count
    }

    //MARK: 3. CellRegisteration 호출
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = user[indexPath.item]
        // cell타입,item타입 두개의 타입이 들어간다.
        let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: item) // 여기서 실행
        return cell
    }

    
}


extension SimpleCollectionViewController {
    private func createlayout() -> UICollectionViewLayout {
        // 14+ 컬렉션뷰를 테이블뷰 스타일 처럼 사용 가능(그게 List configuration)   ( 컬렉션뷰 스타일, 컬렉션뷰 셀과 관련X)
        // list configuration을 가져옴.
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain) // ,plan,.insetGoroup 자주사용
        configuration.showsSeparators = false // separators 구분선 사라짐(위아래 셀의 간격이 사라짐)
        configuration.backgroundColor = .brown //셀이아닌 셀 밖에 배경색이 바뀜.
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout // 위에다 flowlayout 처럼 layout설정.
        return layout
    }
}

