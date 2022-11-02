//
//  ViewController.swift
//  Unsplash
//
//  Created by useok on 2022/10/28.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {
    
    let viewModel = MainViewModel()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.backgroundColor = .blue
        return cv
    }()
    
    
    let disposeBag = DisposeBag()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int,ListPhoto>!  // Int는 색션의항목 ,list(모델의타입), <색션,데이터정보>
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view).offset(100)
            $0.bottom.equalTo(0)
            $0.left.right.equalTo(0)
        }
        configureDataSource()
        bindData()
    }

//    func bindData() {
//        viewModel.photoList.bind { [self] photo in
//            var snapshot = NSDiffableDataSourceSnapshot<Int,ListPhoto>()
////            snapshot.appendSections([0])
////            snapshot.appendSections(photo.urls)
//            dataSource.apply(snapshot)
//        }
//    }
    
    func bindData() {
        viewModel.photoList
            .withUnretained(self)
            .subscribe { (vc,photo) in
                var snapshot = NSDiffableDataSourceSnapshot<Int,ListPhoto>()
                snapshot.appendSections([0])
//                snapshot.appendItems(photo)
                vc.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag )
            
    }
}


extension ViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
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






