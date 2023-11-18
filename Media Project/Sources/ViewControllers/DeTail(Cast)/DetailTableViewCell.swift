//
//  DetailTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import UIKit

class DetailTableViewCell: BaseTableViewCell {
    
    let OverviewTitleLabel = {
        let view = UILabel()
        view.text = "Overview"
        view.font = .systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    let overviewLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.numberOfLines = 0
        return view
    }()
    
    let expandImageView = {
        let view = UIImageView()
        view.tintColor = .black
        return view
    }()
    
    let CastTitleLabel = {
        let view = UILabel()
        view.text = "Cast"
        view.font = .systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    override func configureView() {
        [OverviewTitleLabel, overviewLabel, expandImageView, CastTitleLabel].forEach { contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        
        OverviewTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(contentView).inset(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(OverviewTitleLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView).inset(20)
        }
        
//        expandImageView.snp.makeConstraints { make in
//            make.size.equalTo(20)
//            make.top.equalTo(overviewLabel.snp.bottom).offset(8)
//            make.bottom.equalTo(contentView).inset(8)
//            make.centerX.equalTo(overviewLabel)
//        }
        
        CastTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(30)
            make.leading.equalTo(OverviewTitleLabel)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
    
}
