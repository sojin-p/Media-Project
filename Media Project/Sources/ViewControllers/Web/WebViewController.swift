//
//  WebViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/25.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    var webView = WKWebView()
    var movieKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setURL()
        setBackBarButton()
    }
    
    func setURL() {
        if let myURL = URL(string: "https://www.youtube.com/embed/\(movieKey)?autoplay=1") {
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
    }
    
    func setBackBarButton() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBarbuttonClicked))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem =  backButton
    }
    
    @objc func backBarbuttonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    override func configureView() {
        view.addSubview(webView)
    }
    
    override func setConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
