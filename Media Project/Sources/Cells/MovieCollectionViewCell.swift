//
//  CollectionViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/19.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet var backView: UIView!
    @IBOutlet var movieImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 7
        backView.layer.shadowColor = UIColor.gray.cgColor
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 2
        backView.layer.shadowOpacity = 0.5
        backView.clipsToBounds = false
        
        movieImageView.backgroundColor = .systemGray4
        movieImageView.layer.cornerRadius = 7
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
    }

}
