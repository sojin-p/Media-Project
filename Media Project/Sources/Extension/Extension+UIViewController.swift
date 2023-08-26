//
//  Extension+UIViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/26.
//

import UIKit

extension UIViewController {

    func setWhiteCapsuleButton<T: UIButton>(button: T, title: String, size: UIButton.Configuration.Size) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .white
        config.titleAlignment = .center
        config.cornerStyle = .capsule
        config.buttonSize = size
        button.configuration = config
    }

    func setSkipButtonConstraints<T: UIButton>(button: T) {
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
    }

}
