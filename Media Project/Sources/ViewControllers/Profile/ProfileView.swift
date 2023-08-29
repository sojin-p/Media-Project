//
//  ProfileView.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    
    let tableView = {
        let view = UITableView()
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return view
    }()
    
    override func configureView() {
        super.configureView()
        addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
