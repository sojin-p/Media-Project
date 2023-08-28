//
//  DetailTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import UIKit

class DetailTableViewCell: BaseTableViewCell {
    
    let overviewLabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        return view
    }()
    
    let expandImageView = {
        let view = UIImageView()
        view.tintColor = .black
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(overviewLabel)
        contentView.addSubview(expandImageView)
    }
    
    override func setConstraints() {
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.horizontalEdges.equalTo(contentView).inset(20)
        }
        
        expandImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalTo(overviewLabel.snp.bottom).offset(8)
            make.bottom.equalTo(contentView).inset(8)
            make.centerX.equalTo(overviewLabel)
        }
    }
    
}
