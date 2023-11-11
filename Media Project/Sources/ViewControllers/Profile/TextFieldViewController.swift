//
//  TextFieldViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/29.
//

import UIKit

class TextFieldViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "플레이스 홀더"
        return view
    }()
    
    var delegate: PassNicknameDelegate?
    
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let text = textField.text else { return }
        
        delegate?.receiveNickname(nickname: text)
        
        NotificationCenter.default.post(name: .userName, object: nil, userInfo: ["name": text])
        
        completionHandler?(text)
        
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
