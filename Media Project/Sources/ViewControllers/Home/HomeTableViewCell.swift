//
//  HomeTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/11.
//

import UIKit

final class HomeTableViewCell: BaseTableViewCell {
    
    let posterImageView = {
        let view = UIImageView()
        return view
    }()
    
    let testLabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "test"
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(testLabel)
    }
    
    override func setConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(contentView.snp.width).multipliedBy(1.3)
            make.centerX.equalToSuperview()
        }
        
        testLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView).offset(10)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
