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
    
    var trendingData: [PopularResult] = []
    var popularData: [PopularResult] = []
    var upcomingData: [PopularResult] = []
    var nowPlayingData: [PopularResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("====viewDidLoad")
        view.backgroundColor = .white
        title = "Home"
        tableView.delegate = self
        tableView.dataSource = self
        
//        let group = DispatchGroup()
        callRequest(api: .trending(filter: .movie))
//        callRequest(api: .popular)
//        callRequest(api: .upcoming)
//        callRequest(api: .now_playing)
        
    }
    
    func callRequest(api: Router) {
        
        TmdbAPIManager.shared.requestConvertible(type: PopularData.self, api: api) { [weak self] response in
            switch response {
            case .success(let success):
                switch api {
                case .trending(_):
                    self?.trendingData = success.results
                    dump(self?.trendingData)
                    
                case .popular:
                    self?.popularData = success.results
                    dump(self?.popularData)
                    
                case .upcoming:
                    self?.upcomingData = success.results
                    dump(self?.upcomingData)
                    
                case .now_playing:
                    self?.nowPlayingData = success.results
                    dump(self?.nowPlayingData)
                default: print("default")
                }
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
        
//        TmdbAPIManager.shared.requestConvertible(type: PopularData.self, api: .popular) { [weak self] response in
//            switch response {
//            case .success(let success):
//                self?.popularData = success.results
//                dump(self?.popularData)
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
//        
//        TmdbAPIManager.shared.requestConvertible(type: PopularData.self, api: .upcoming) { [weak self] response in
//            switch response {
//            case .success(let success):
//                self?.upcomingData = success.results
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
//        
//        TmdbAPIManager.shared.requestConvertible(type: PopularData.self, api: .now_playing) { [weak self] response in
//            switch response {
//            case .success(let success):
//                self?.nowPlayingData = success.results
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
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
