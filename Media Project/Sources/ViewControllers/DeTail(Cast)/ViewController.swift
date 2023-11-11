//
//  ViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/11.
//

import UIKit

final class ViewController: BaseViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        view.register(DetailCastTableViewCell.self, forCellReuseIdentifier: DetailCastTableViewCell.identifier)
        view.separatorStyle = .none
        view.estimatedRowHeight = 120
        return view
    }()
    
    let backdropImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .brown
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
        view.backgroundColor = .systemYellow
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "타이틀입니다타이틀입니다타이틀입니다타이틀입니다타이틀입니다타이틀입니다"
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.numberOfLines = 0
        return view
    }()
    
    let playButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "star.fill"), for: .normal)
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func configureView() {
        view.addSubview(tableView)
        tableView.tableHeaderView = backdropImageView
        [posterImageView, alphaView, titleLabel, playButton].forEach { backdropImageView.addSubview($0) }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        backdropImageView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        tableView.tableHeaderView?.layoutIfNeeded()
        
        alphaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(20)
            make.width.equalTo(backdropImageView).multipliedBy(0.25)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView)
            make.leading.equalTo(posterImageView.snp.trailing).offset(15)
            make.trailing.equalTo(playButton.snp.leading).offset(-15)
        }
        
        playButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.trailing.equalTo(backdropImageView).offset(-20)
            make.centerY.equalTo(titleLabel)
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
            
            cell.overviewLabel.text = "Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful."
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCastTableViewCell.identifier, for: indexPath) as? DetailCastTableViewCell else { return UITableViewCell() }
            
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return UITableView.automaticDimension
        default: return 120
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
