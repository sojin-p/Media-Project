//
//  HomeCollectionViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/11.
//

import UIKit

final class HomeCollectionViewCell: BaseCollectionViewCell {
    
    let backView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let posterImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(backView)
        backView.addSubview(posterImageView)
    }
    
    override func setConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
