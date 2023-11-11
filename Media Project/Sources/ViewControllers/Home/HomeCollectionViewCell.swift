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
        return view
    }()
    
    let testLabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "\(Int.random(in: 1...100))"
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(testLabel)
    }
    
    override func setConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        testLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView).offset(10)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
