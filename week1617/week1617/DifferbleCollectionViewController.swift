//
//  DifferbleCollectionViewController.swift
//  week1617
//
//  Created by useok on 2022/10/19.
//

import UIKit

class DifferbleCollectionViewController: UIViewController {
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var list = ["아이폰","맥북","아이패드","애플워치","에어팟"]
//  let cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell,String>!
    
    private var dataSource: UICollectionViewDiffableDataSource<Int,String>!  // Int는 색션의항목 ,list(모델의타입), <색션,데이터정보>
    override func viewDidLoad() {
        super.viewDidLoad()
        cv.collectionViewLayout = createLayout() // layout 설정
        configureDataSource()
        cv.delegate = self // cell 클릭시 필요
        
        searchBar.delegate = self
    }
}


extension DifferbleCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    private func configureDataSource() {
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell,String> (handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.secondaryText = "\(itemIdentifier.count)"
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 10
            background.strokeColor = .blue
            cell.backgroundConfiguration = background
             
        })
        // cv.dataSource = self 필요없다. cellforRow,numberofsection 대신에씀
        dataSource = UICollectionViewDiffableDataSource(collectionView: cv, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier) // indexPath, itemIdentifier 둘다 이용해서 cell에 접근가능
            return cell
        })
        
        // inital
        var snapshot = NSDiffableDataSourceSnapshot<Int,String>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }
}

extension DifferbleCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var snapshot = dataSource.snapshot() // snapshot은 현재 상태 복사본
        snapshot.appendItems([searchBar.text!]) // 검색결과 append
        dataSource.apply(snapshot,animatingDifferences: true) // 이떄 View에 반영
    }
}


extension DifferbleCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else {return}
        print(item)
        print(indexPath)
        
//        let item = list[indexPath.item]
        let alert = UIAlertController(title: item, message: "클릭!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert,animated: true)
    }
}