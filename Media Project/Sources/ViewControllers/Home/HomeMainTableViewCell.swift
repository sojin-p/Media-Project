//
//  HomeMainTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/11.
//

import UIKit

final class HomeMainTableViewCell: BaseTableViewCell {
    
    let titleLabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "title"
        return view
    }()
    
    let collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        return view
    }()
    
    override func configureView() {
        [collectionView, titleLabel].forEach { contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    private static func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        
        return layout
    }
}
