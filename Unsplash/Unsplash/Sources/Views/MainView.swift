//
//  MainView.swift
//  Unsplash
//
//  Created by useok on 2022/11/02.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }

    private var dataSource: UICollectionViewDiffableDataSource<Int,ListPhoto>!  // Int는 색션의항목 ,list(모델의타입), <색션,데이터정보>

    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.backgroundColor = .blue
        return cv
    }()
    
    
    
    override func setConstrains() {
        <#code#>
    }
    
    
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    func configureDataSource() {
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell,ListPhoto> {
            cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.listPhotoDescription)"
            cell.contentConfiguration = content
            
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 10
            background.strokeColor = .yellow
            cell.backgroundConfiguration = background
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}
