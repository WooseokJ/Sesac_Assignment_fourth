
import UIKit

import RxSwift
import RxCocoa
import RxAlamofire
import RxDataSources

class SubscribeViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: {  dataSource , tableView,IndexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "\(item)"
        return cell
    })
    
    func testRxDataSource() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        dataSource.titleForFooterInSection = { dataSource,index in
            return dataSource.sectionModels[index].model
        }
        Observable.just(
            [SectionModel(model: "title1", items: [1, 2, 31]),
             SectionModel(model: "title2", items: [4, 5, 32]),
             SectionModel(model: "title3", items: [7, 8, 33])
            ]
        )
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    
    }
    
    
    func testRxAlamofire() {
        let url = APIKey.searchURL+"apple"
    
        //success error -> <single>
        request(.get,url,headers: ["Authorization": APIKey.authorization]) // ((받을지,보낼지선택), url,header)
            .data()
            .decode(type: SearchPhoto.self, decoder: JSONDecoder()) // decode를 쓰면 편하게 쓸수있다. !!
            
            .subscribe{ val in
                print("-=-=-=-=-",val.results[0])
            }
            .disposed(by: disposeBag)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testRxAlamofire()
        testRxDataSource()
        
//        Observable.of(1,2,3,4,5,6,7,8,9,10)
//            .skip(3) // 4,5,6,7,8,9,10
//            .filter{ $0 % 2 == 0 } //  4 6 8 10
//            .debug()
//            .map{ $0 * 2 } // 8 12 16 20
//            .subscribe { value in
//                print("===\(value)") // 출력
//            }
//            .disposed(by: disposeBag)

        
        
        
        
        /*
        //1,2,3,4,5,6 동일한코드
        // 1
        
        let sample = button.rx.tap
        
        sample
            .withUnretained(self)
            .subscribe { (vc,_) in
                vc.label.text = "안녕1"
            }
            .disposed(by: disposeBag)
        // 2
        sample
            .subscribe{[weak self] _ in
                self?.label.text = "안녕2"
            }
            .disposed(by: disposeBag)
        // 3. 네트워크 통신 ,파일다운로드 등 백그라운드 작업?

        // 아래 MainScheduler.instance와 동일
        sample
            .withUnretained(self)
            .subscribe { (vc,_) in
                DispatchQueue.main.async { // .observe(on: MainScheduler.instance)
                    vc.label.text = "안녕1"

                }
            }
            .disposed(by: disposeBag)
        
        
        sample
//            .map{} //global
//            .map{} //global
//            .map{} //global
            .observe(on: MainScheduler.instance) // 데이터 시퀀스가 흘러가면서 main쓰레드로 바꿔줌.  이부분에서 main쓰레드에서 동작
//            .map{} //main
//            .map{} //main
//            .map{} //main
            .withUnretained(self)
            .subscribe{ ( vc , _ ) in
                vc.label.text = "안녕3"
            }
            .disposed(by: disposeBag)
        
        // 4. bind등장 : subscirbe, mainSchedular, errorX
        sample
            .withUnretained(self)
            .bind { (vc,_) in // bind,subscribe둘다 구독하는것(bind는 다만 mainThread에서만 동작한다.그래서 error발생을 안함. )
                vc.label.text = "안녕4"
            }
            .disposed(by: disposeBag)
        
        // 5 . operator 데이터의 stream 조작
        sample
            .map { "안녕5" }
            .bind(to: label.rx.text )
            .disposed(by: disposeBag)
        
        // 6. driver traits: bind + stream이 공유될수있다.(리소스 낭비를 방지할수있다.)
        sample
            .map{"안녕6"}
            .asDriver(onErrorJustReturn: "") //에러발생시 어떤 키워드쓸래? 할떄 사용 , 보통은 빈 문자열("") 로 둔다.
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        
        */
        
        
    }
  
    
        
        
    
    
    
    
}
