//
//  DetailCastTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/11.
//

import UIKit

final class DetailCastTableViewCell: BaseTableViewCell {
    
    let collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private static func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 15
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)

        return layout
    }
}
