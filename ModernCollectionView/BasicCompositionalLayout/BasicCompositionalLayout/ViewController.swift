//
//  ViewController.swift
//  BasicCompositionalLayout
//
//  Created by 양준수 on 2/19/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

// 섹션과 아이템 정의
struct Section: Hashable {
    let id: String
}
enum Item: Hashable {
    case banner(HomeItem)
    case normalCarousel(HomeItem)
    case listCarousel(HomeItem)
}
struct HomeItem: Hashable {
    let title: String
    let subTitle: String?
    let imageUrl: String
}
//컬렌션뷰 cell UI - 등록
//레이아웃 구현 - 3가지
//datasource => cellProvider
//snapshot => datasource.apply(snapshot)
