//
//  CollectionViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/19.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet var movieImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImageView.backgroundColor = .blue
    }

}
