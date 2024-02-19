//
//  BannerCollectionViewCell.swift
//  BasicCompositionalLayout
//
//  Created by 양준수 on 2/20/24.
//

import Foundation
import SnapKit
import UIKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    static let id = "BannerCollectionViewCell"
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    private func setUI() {
     
        self.addSubview(backgroundImage)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints { make in
//            make.leading.trailing.top.bottom.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
    
    func config(title: String, imageUrl: String) {
        titleLabel.text = title
        backgroundImage.kf.setImage(with: URL(string: imageUrl))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
