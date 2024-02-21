//
//  NormalCaroselCollectionViewCell.swift
//  BasicCompositionalLayout
//
//  Created by 양준수 on 2/21/24.
//

import Foundation
import Kingfisher
import SnapKit
import UIKit
class NormalCaroselCollectionViewCell: UICollectionViewCell {
    static let id = "NormalCaroselCollectionViewCell"
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        [mainImage,titleLabel,subtitleLabel]
            .forEach { sub in
                addSubview(sub)
            }
        
        mainImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(mainImage.snp.bottom).offset(8)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    func config(imageUrl: String, title: String, subTitle:String ) {
        mainImage.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = title
        subtitleLabel.text = subTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
