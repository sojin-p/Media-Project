//
//  CastTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet var castImageView: UIImageView!
    @IBOutlet var castTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        castImageView.backgroundColor = .systemGray5
        castImageView.layer.cornerRadius = 7
        castTitleLabel.font = .systemFont(ofSize: 14)
        
    }

    
}
