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
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var trendTitleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.backgroundColor = .blue
        trendTitleLabel.text = "되나"
    }
    
}
