//
//  ProfileTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/29.
//

import UIKit

class ProfileTableViewCell: BaseTableViewCell {
    
    let titleLabel = {
        let view = UILabel()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    let textField = {
        let view = UITextField()
        view.borderStyle = .none
        view.placeholder = "testtest"
        view.backgroundColor = .brown
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        textField.snp.makeConstraints { make in
            make.verticalEdges.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
        }
    }
    
}
 
