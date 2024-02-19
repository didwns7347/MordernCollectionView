//
//  ViewController.swift
//  BasicCompositionalLayout
//
//  Created by 양준수 on 2/19/24.
//

import UIKit

class ViewController: UIViewController {
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
        return UICollectionViewCompositionalLayout(sectionProvider: {[weak self] sectionIndex, _ in
            
            return self?.createBannerSection()
        })
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
        
        dataSource?.apply(snapshot)
    }
}


//컬렌션뷰 cell UI - 등록
//레이아웃 구현 - 3가지
//datasource => cellProvider
//snapshot => datasource.apply(snapshot)
