//
//  textFieldViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/29.
//

import UIKit

class textFieldViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "플레이스 홀더"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
}
