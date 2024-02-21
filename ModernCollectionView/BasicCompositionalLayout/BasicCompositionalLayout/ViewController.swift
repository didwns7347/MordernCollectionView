//
//  ViewController.swift
//  BasicCompositionalLayout
//
//  Created by 양준수 on 2/19/24.
//

import UIKit

class ViewController: UIViewController {
    let sampleImageUrl = "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F91%2Fd4%2Fa1%2F91d4a1a649745682b94ea8ddf2b8c7b9.jpg&type=a340"
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: .init()
    )
    private var dataSource: UICollectionViewDiffableDataSource<Section,Item>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUI()
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.register(NormalCaroselCollectionViewCell.self, forCellWithReuseIdentifier: NormalCaroselCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        setDataSrouce()
        setSnapShot()
    }
    
    private func setUI(){
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        
        return UICollectionViewCompositionalLayout(sectionProvider: {[weak self] sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self?.createBannerSection()
            case 1:
                return self?.createNormerSection()
//            case 2:
            default:
                return self?.createBannerSection()
            }
//            return self?.createBannerSection()
        }, configuration: config)
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitems: [item])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createNormerSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitems: [item])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func setDataSrouce() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: self.collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                switch itemIdentifier {
                case .banner(let item):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell
                    else {
                         return UICollectionViewCell()
                    }
                    //
                    cell.config(title: item.title, imageUrl: item.imageUrl)
                    return cell
                case .normalCarousel(let item):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCaroselCollectionViewCell.id, for: indexPath) as? NormalCaroselCollectionViewCell
                    else {
                         return UICollectionViewCell()
                    }
                    //
//                    cell.config(title: item.title, imageUrl: item.imageUrl)
                    cell.config(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle ?? "")
                    return cell
                default :
                    return UICollectionViewCell()
                }

           
            }
        )
    }
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        
        
        snapshot.appendSections([Section(id: "Banner")])
        let bannerItems = [
            Item.banner(HomeItem(
                title: "교촌 치킨",
                imageUrl: "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F91%2Fd4%2Fa1%2F91d4a1a649745682b94ea8ddf2b8c7b9.jpg&type=a340")
            ),
            Item.banner(HomeItem(
                title: "굽네 치킨",
                imageUrl: "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F91%2Fd4%2Fa1%2F91d4a1a649745682b94ea8ddf2b8c7b9.jpg&type=a340")
            ),
            Item.banner(HomeItem(
                title: "푸라닭 치킨",
                imageUrl: "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F91%2Fd4%2Fa1%2F91d4a1a649745682b94ea8ddf2b8c7b9.jpg&type=a340")
            )
        ]
        snapshot.appendItems(bannerItems, toSection: Section(id: "Banner"))
        
        
        snapshot.appendSections([Section(id:"NormalCerosel")])
        
        let normalItems = [
            Item.normalCarousel(HomeItem(title: "교촌치킨", imageUrl: sampleImageUrl, subtitle: "간장치킨")),
            Item.normalCarousel(HomeItem(title: "굽내치킨", imageUrl: sampleImageUrl, subtitle: "오븐치킨")),
            Item.normalCarousel(HomeItem(title: "BBQ", imageUrl: sampleImageUrl, subtitle: "올리브치킨")),
            Item.normalCarousel(HomeItem(title: "프라닭", imageUrl: sampleImageUrl, subtitle: "프리미엄치킨")),
            Item.normalCarousel(HomeItem(title: "처가집", imageUrl: sampleImageUrl, subtitle: "양념치킨"))
        ]
        snapshot.appendItems(normalItems, toSection: Section(id: "NormalCerosel"))
        dataSource?.apply(snapshot)
    }
}


//컬렌션뷰 cell UI - 등록
//레이아웃 구현 - 3가지
//datasource => cellProvider
//snapshot => datasource.apply(snapshot)
