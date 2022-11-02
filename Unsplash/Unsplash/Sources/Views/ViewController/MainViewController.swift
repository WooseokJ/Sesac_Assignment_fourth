//
//  ViewController.swift
//  Unsplash
//
//  Created by useok on 2022/10/28.
//

import UIKit
import SnapKit
import RxSwift

class MainViewController: BaseViewController {
    
    let viewModel = MainViewModel()
    
    let mainView = MainView()
    override func loadView() {
        super.view = mainView
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view).offset(100)
            $0.bottom.equalTo(0)
            $0.left.right.equalTo(0)
        }
        mainView.
        configureDataSource()
        bindData()
    }
    
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


extension MainViewController {
    
   
    
}






