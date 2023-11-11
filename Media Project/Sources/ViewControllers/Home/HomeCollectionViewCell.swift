//
//  HomeCollectionViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/11.
//

import UIKit

final class HomeCollectionViewCell: BaseCollectionViewCell {
    
    let posterImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(posterImageView)
    }
    
    override func setConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
