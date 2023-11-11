//
//  HomeViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/11.
//

import UIKit
import SnapKit

final class HomeViewController: BaseViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        view.register(HomeMainTableViewCell.self, forCellReuseIdentifier: HomeMainTableViewCell.identifier)
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("====viewDidLoad")
        view.backgroundColor = .white
        title = "Home"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func configureView() {
        view.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
            
            cell.posterImageView.backgroundColor = .systemYellow
            cell.testLabel.text = "\(indexPath)"
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeMainTableViewCell.identifier, for: indexPath) as? HomeMainTableViewCell else { return UITableViewCell() }
            
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return UITableView.automaticDimension
        default: return 200
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 300
        default: return 200
        }
    }

}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
