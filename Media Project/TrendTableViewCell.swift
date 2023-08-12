//
//  TrendTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import UIKit

class TrendTableViewCell: UITableViewCell {
    
    @IBOutlet var trendImageView: UIImageView!
    @IBOutlet var trendTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        trendImageView.backgroundColor = .blue
        trendTitleLabel.text = "되나"
    }
    
}
