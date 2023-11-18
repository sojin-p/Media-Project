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
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    var cast: [Cast] = []
    
    override func configureView() {
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(cast: [Cast]) {
        self.cast = cast
        collectionView.reloadData()
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

extension DetailCastTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }

        if indexPath.item < cast.count {
            let item = cast[indexPath.item].profilePath ?? ""
            let url = URL(string: URL.imageURL + item)
            cell.castImageView.kf.setImage(with: url)
        }
        
        return cell
    }
}

