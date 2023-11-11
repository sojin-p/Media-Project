//
//  HomeTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/11.
//

import UIKit

final class HomeTableViewCell: BaseTableViewCell {
    
    let containerView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3) //햇빛 방향
        view.layer.shadowRadius = 4 //퍼짐의 정도
        view.layer.shadowOpacity = 0.3 //0~1 사이에서 투명도 조절
        view.clipsToBounds = false
        return view
    }()
    
    let posterImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    let posterBackImageView = {
        let view = UIImageView()
        view.image = Image.posterBackground
        view.layer.cornerRadius = 20
        view.alpha = 0.5
        view.clipsToBounds = true
        return view
    }()
    
    let testLabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "test"
        return view
    }()
    
    let playButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        view.backgroundColor = .white
        return view
    }()
    
    override func configureView() {
        [containerView, testLabel].forEach {  contentView.addSubview($0) }
        [posterImageView, posterBackImageView, playButton].forEach { containerView.addSubview($0) }
    }
    
    override func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(containerView.snp.width).multipliedBy(1.3)
            make.centerX.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        posterBackImageView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        testLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView).offset(10)
            make.horizontalEdges.equalToSuperview()
        }
        
        playButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalToSuperview().inset(15)
        }
    }
}
