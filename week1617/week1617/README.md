collection view APIs



1. CollectionVIew 흐름

ios 6 :  collectionview 처음등장

* UIcollectionDataSource(인덱스 기반 프로토콜)
* UIcollectionViewLayout - UIcollectionFlowLayout(하위클래스)

iod 13  : diffableDataSource, Compositional layout  최신 API 등장

ios 14 이후

List configuration은 compositional layout 기반으로 만들어짐(테이블뷰처럼쓸수있음)

(ios 14 에서  list Configuration이 나온이유는 컬렉션뷰를 테이블뷰처럼 쓰고싶어서 나온개념. 

그래서 Compositional layout의 기능에서 list configuration 이 추가된거.)



|            | data                   | layout                 | presentation                                |
| ---------- | ---------------------- | ---------------------- | ------------------------------------------- |
| ios 13이전 | UIcollectionDataSource | UIcollectionViewLayout | UIcollectionCell / UIcollectionReusableView |
| ios 13     | DiffableDataSource     | Compositional layout   | UIcollectionCell / UIcollectionReusableView |
| ios 14     | section snapshots      | list configuration     | List cell   / view configuration            |



2. UIcollectionLayoutListconfiguration 

| list configuration                                           |
| ------------------------------------------------------------ |
| UIcollectionLayoutListconfiguration(list)                    |
| UIcollectionViewCompositionalLayout(compositional Layout)   ios 13 |
| NScollectionLayoutSection(compositional Layout)   ios 13     |

- List 형태의 레아아웃 만들기위한 구조체

- UIcollectionLayoutListconfiguration의 apearance 설정들: plain, grouped, inset grouped 
- 그외 separator,header,footer,swipe 처리 가능



3. UICollectionView.CellRegistration

- ios 14이후 등장한 Registeration API 로 셀재사용보다 쉽게 구현
- 기존 Cell identifier,Xib대신 제네릭형태 사용, 새셀이 생성될떄마다 클로저가 호출

4. UIContentConfiguration (프로토콜)
   - ContentView에 configuration을 제공하는 객체
   - UIListContentConfiguration(구조체)도 UIContentConfiguration(프로토콜) 채택

5. UIListContentConfiguration
   - list base 컨텐츠 뷰를 구성하는 configuration으로 시스템 기본스타일 설정

# UICollectionViewCompositionalLayout

<img src="/Users/apple/Library/Application Support/typora-user-images/스크린샷 2022-10-18 오후 5.51.00.png" width="400" height="500">

3가지 컴포넌트로 구성

- Section(NSCollectionLayoutSection) : 배경,Header,Footer갖을수있다.
- Group(NScollectionLayoutGroup): group -> section에 주입 ,NScollectionLaoutDimenstion으로 크기설정가능
- Item(NSCollectionLayoutItem): item -> Group에 주입,NScollectionLaoutDimenstion으로 크기설정가능

## NSCollectionLayoutDimension

collectionView item 크기 결정하는 3가지 방법

- absoulte : 절대크기 (고정된크기)   ex ) .absolute(44)
- estimated: 시스템 글꼴크기변경같이 크기변할수있는경우 사용, 시스템이 예상 크기를 기반으로 실제 크기를 계산 ex) .estimated(44)
- fractional: 현재 자신이속한 컨테이너 크기의 비율에 맞게 크기설정.