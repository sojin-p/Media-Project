//
//  BaseViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/28.
//

import UIKit
import Kingfisher

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func setConstraints() { }

}
