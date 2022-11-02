//
//  DifferbleCollectionViewController.swift
//  week1617
//
//  Created by useok on 2022/10/19.
//

import UIKit
import Kingfisher

import RxSwift
import RxCocoa

class DifferbleCollectionViewController: UIViewController {
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
//    var list = ["아이폰","맥북","아이패드","애플워치","에어팟"]
//    let cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell,String>!
    
    var viewModel = differbleViewModel()
    
    var disposeBag = DisposeBag()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int,SearchResult>!  // Int는 색션의항목 ,list(모델의타입), <색션,데이터정보>
    override func viewDidLoad() {
        super.viewDidLoad()
        cv.collectionViewLayout = createLayout() // layout 설정
        configureDataSource()
        cv.delegate = self // cell 클릭시 필요
        searchBar.delegate = self
        
        bindData()
//        APIService.searchPhoto(query: "apple") // test용
    }
    
    
//    func bindData() {
//        viewModel.photoList.bind { [self] photo in
//            var snapshot = NSDiffableDataSourceSnapshot<Int,SearchResult>()
//            snapshot.appendSections([0])
//            snapshot.appendItems(photo.results)
//            dataSource.apply(snapshot)
//        }
//    }
    
    // rx활용
    func bindData() {
        viewModel.photoList
            .withUnretained(self)
            .subscribe(onNext: { (vc,photo) in
                var snapshot = NSDiffableDataSourceSnapshot<Int,SearchResult>()
               snapshot.appendSections([0])
               snapshot.appendItems(photo.results)
               vc.dataSource.apply(snapshot)
            }, onError: { error in
                print("======\(error)=====")
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            })
            .disposed(by: disposeBag) // .disposed(by: DisposeBag())을 해버리면 새로운 인스턴스를 만들게되므로 안된다.




        searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe { (vc,value) in
                vc.viewModel.requestSearchPhoto(query: value)
            }
            .disposed(by: disposeBag)
    }
}


extension DifferbleCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    private func configureDataSource() {
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell,SearchResult> (handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            
            //사용못함
//            let url = URL(string: "asd")  // string -> url -> data -> image
//            content.image?.kf.setImage(url) // kf가 imageview에서 쓸수있는데 content.image가 image타입이라 안맞아서 사용못함.
            
            // 그래서 이거사용
            DispatchQueue.global().async { // string -> url -> data -> image
                let url = URL(string: itemIdentifier.urls.thumb)// thub 화질안좋은 사진, string -> url
                let data = try? Data(contentsOf: url!) // url -> data
                content.image = UIImage(data: data!) // data - > image
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
            
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 10
//            background.strokeColor = .blue
            cell.backgroundConfiguration = background
             
        })
        // cv.dataSource = self 필요없다. cellforRow,numberofsection 대신에씀
        dataSource = UICollectionViewDiffableDataSource(collectionView: cv, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier) // indexPath, itemIdentifier 둘다 이용해서 cell에 접근가능
            return cell
        })
 
    }
}

extension DifferbleCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        var snapshot = dataSource.snapshot() // snapshot은 현재 상태 복사본
//        snapshot.appendItems([searchBar.text!]) // 검색결과 append
//        dataSource.apply(snapshot,animatingDifferences: true) // 이떄 View에 반영

        viewModel.requestSearchPhoto(query: searchBar.text!)
    }
}



extension DifferbleCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        guard let item = dataSource.itemIdentifier(for: indexPath) else {return}
//        print(item)
//        print(indexPath)
//
////        let item = list[indexPath.item]
//        let alert = UIAlertController(title: item, message: "클릭!", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "확인", style: .cancel)
//        alert.addAction(ok)
//        present(alert,animated: true)
    }
}
