//
//  TrendTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import UIKit

class TrendTableViewCell: UITableViewCell {
    
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var posterBackView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var trendTitleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailImageView.image = UIImage(systemName: "chevron.right")
        detailImageView.tintColor = .black
        
        posterBackView.layer.cornerRadius = 15
        posterBackView.clipsToBounds = true
        
        backView.layer.cornerRadius = 15
        backView.layer.shadowColor = UIColor.gray.cgColor
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 7
        backView.layer.shadowOpacity = 0.5
        backView.clipsToBounds = false
        
        releaseDateLabel.font = .systemFont(ofSize: 13)
        releaseDateLabel.textColor = .gray
        
        genreLabel.font = .boldSystemFont(ofSize: 20)
        
        trendTitleLabel.font = .boldSystemFont(ofSize: 20)
        
        overviewLabel.textColor = .gray
        overviewLabel.font = .systemFont(ofSize: 13)
        
        detailLabel.text = "자세히 보기"
        detailLabel.font = .boldSystemFont(ofSize: 12)
        
    }
    
}
