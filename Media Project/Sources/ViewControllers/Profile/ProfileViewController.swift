//
//  ProfileViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/29.
//

import UIKit

protocol PassNicknameDelegate {
    func receiveNickname(nickname: String)
}

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    var titleList = ["이름", "사용자 이름", "성별 대명사", "소개", "링크", "성별"]
    var contentList: [String] = ["이름", "사용자 이름", "성별 대명사", "소개", "링크", "성별"]
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .userName, object: nil)
        
    }
    
    override func configureView() {
        title = "프로필 편집"
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = 50
    }
    
    @objc func doneUserNameNotification(notification: NSNotification) {
        print("doneUserNameNotification 값 전달")
        
        if let name = notification.userInfo?["name"] as? String {
            contentList.insert(name, at: 1)
            mainView.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = titleList[indexPath.row]
        
        if contentList == titleList {
            cell.textFieldLabel.text = titleList[indexPath.row]
        } else {
            cell.textFieldLabel.text = contentList[indexPath.row]
            cell.textFieldLabel.textColor = .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TextFieldViewController()
        
        if indexPath.row == 0 {
            vc.delegate = self
        } else if indexPath.row == 1 {
            NotificationCenter.default.addObserver(self, selector: #selector(doneUserNameNotification), name: .userName, object: nil)
        } else {
            print("쉽지않네")
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: PassNicknameDelegate {
    
    func receiveNickname(nickname: String) {
        print("protocol 값 전달", nickname)
        contentList.insert(nickname, at: 0)
        mainView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    
}
