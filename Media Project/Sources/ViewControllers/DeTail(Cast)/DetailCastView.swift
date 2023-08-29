//
//  DetailCastView.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/28.
//

import UIKit

class DetailCastView: BaseView {
    
    let tableView = {
        let view = UITableView()
        view.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        view.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        return view
    }()
    
    let backdropImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let alphaView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    let posterImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    override func configureView() {
        super.configureView()
        
        addSubview(tableView)
        tableView.tableHeaderView = backdropImageView
        backdropImageView.addSubview(alphaView)
        backdropImageView.addSubview(titleLabel)
        backdropImageView.addSubview(posterImageView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        backdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        alphaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(20)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(20)
            make.width.equalTo(backdropImageView.snp.height).multipliedBy(0.5)
        }
    }
    
}
