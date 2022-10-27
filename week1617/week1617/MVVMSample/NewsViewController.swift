//
//  NewsViewController.swift
//  week1617
//
//  Created by useok on 2022/10/20.
//

import UIKit
import RxSwift
import RxCocoa

class NewsViewController: UIViewController {

   
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var numberTextField: UITextField!
    
    var viewmodel = NewsViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureDataSource()
        bindData()
        
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
//        resetButton.addTarget(self, action: #selector(resetButtonTap), for: .touchUpInside)
//        loadButton.addTarget(self, action: #selector(loadButtonTap), for: .touchUpInside)
    }
    @objc func numberTextFieldChanged() {
        // 123,412,341,234
        guard let text = numberTextField.text else  {return}
        viewmodel.chagePageNumberFormat(text: text)
    }
    
//    @objc func resetButtonTap() {
//        viewmodel.resetSample()
//    }
//    @objc func loadButtonTap() {
//        viewmodel.loadSample()
//    }
    
//    func bindData() {
//
//        viewmodel.pageNumber.bind { val in
//            print("bind == \(val)")
//            self.numberTextField.text = val
//        }
//        viewmodel.sample.bind { item in
//            print("sample bind == \(item)")
//            var snapshot = NSDiffableDataSourceSnapshot<Int,News.NewsItem>()
//            snapshot.appendSections([0])
//            snapshot.appendItems(item)
//            self.dataSource.apply(snapshot,animatingDifferences: true)
//        }
//    }
    
    
    
    var disposeBag = DisposeBag()
    
    /// rxswift에서 쓰는 bind 사용
    func bindData() {
        viewmodel.sample
            .withUnretained(self)
            .bind{ (vc,item) in
                var snapshot = NSDiffableDataSourceSnapshot<Int,News.NewsItem>()
                snapshot.appendSections([0])
                snapshot.appendItems(item)
                vc.dataSource.apply(snapshot,animatingDifferences: true)
            }
            .disposed(by: disposeBag)
        loadButton.rx.tap
            .withUnretained(self)
            .bind { (vc,_ )in  //실패할가능성 고려안해도되므로
                vc.viewmodel.loadSample()
            }
        resetButton.rx.tap
            .withUnretained(self)
            .bind { (vc,_) in
                vc.viewmodel.resetSample()
            }
    }
    
    
    
    
}

extension NewsViewController {
    // addSubView, init,snapkit
    func configureHierachy() {
        cv.collectionViewLayout = createLayout()
        cv.backgroundColor = .lightGray
    }
    
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell,News.NewsItem> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: cv, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
//        var snapshot = NSDiffableDataSourceSnapshot<Int,News.NewsItem>()
//        snapshot.appendSections([0])
//        snapshot.appendItems(News.items)
//        dataSource.apply(snapshot,animatingDifferences: true)
//
    }
    
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
}
