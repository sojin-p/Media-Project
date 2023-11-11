//
//  CastCollectionViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/11.
//

import UIKit

final class CastCollectionViewCell: BaseCollectionViewCell {
    
    let castImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        DispatchQueue.main.async {
            view.layer.cornerRadius = view.frame.width / 2
        }
        view.backgroundColor = .systemGray4
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override func configureView() {
        [castImageView].forEach { contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        castImageView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.edges.equalToSuperview()
        }
    }
    
}
