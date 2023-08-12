//
//  DetailTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet var overviewTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        overviewTextView.isEditable = false
    }
    
}
