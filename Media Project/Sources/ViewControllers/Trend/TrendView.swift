//
//  TrendView.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/31.
//

import UIKit

class TrendView: BaseView {
    
    let tableView = {
        let view = UITableView()
        view.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
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
