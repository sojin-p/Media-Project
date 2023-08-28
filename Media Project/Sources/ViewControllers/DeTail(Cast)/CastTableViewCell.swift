//
//  CastTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import UIKit

class CastTableViewCell: BaseTableViewCell {
    
    let castImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemGray4
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let castTitleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(castImageView)
        contentView.addSubview(castTitleLabel)
    }
    
    override func setConstraints() {
        castImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.verticalEdges.equalTo(contentView).inset(8)
            make.width.equalTo(contentView.snp.height).multipliedBy(0.6)
        }
        
        castTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(castImageView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView).inset(20)
            make.verticalEdges.equalTo(castImageView)
        }
    }
    
}
