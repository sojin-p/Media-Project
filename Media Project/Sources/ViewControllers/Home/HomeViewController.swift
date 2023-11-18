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
    
    var homeData: [PopularData] = [
        PopularData(page: 0, results: [], totalPages: 0, totalResults: 0),
        PopularData(page: 0, results: [], totalPages: 0, totalResults: 0),
        PopularData(page: 0, results: [], totalPages: 0, totalResults: 0),
        PopularData(page: 0, results: [], totalPages: 0, totalResults: 0)
    ]
    
    let randomInt = Int.random(in: 0...19)
    
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("====viewDidLoad")
        view.backgroundColor = .white
        title = "Home"
        tableView.delegate = self
        tableView.dataSource = self

        callRequest(api: .trending(filter: .movie))
        callRequest(api: .popular)
        callRequest(api: .upcoming)
        callRequest(api: .now_playing)
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
        
    }
    
    func callRequest(api: Router) {
        group.enter()
        TmdbAPIManager.shared.requestConvertible(type: PopularData.self, api: api) { [weak self] response in
            switch response {
            case .success(let success):
                switch api {
                case .trending(_):
                    self?.homeData[1].results.append(contentsOf: success.results)
                    
                case .popular:
                    self?.homeData[0].results.append(contentsOf: success.results)
                    
                case .upcoming:
                    self?.homeData[3].results.append(contentsOf: success.results)
                    
                case .now_playing:
                    self?.homeData[2].results.append(contentsOf: success.results)
                    
                default: print("default")
                }
                self?.group.leave()
                
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
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
        default: return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
            
            if indexPath.row < homeData[3].results.count {
                let randomMovie = homeData[3].results[randomInt].posterPath ?? ""
                let url = URL(string: URL.imageURL + randomMovie)
                cell.posterImageView.kf.setImage(with: url)
            }
            cell.selectionStyle = .none
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeMainTableViewCell.identifier, for: indexPath) as? HomeMainTableViewCell else { return UITableViewCell() }
            
            let titleList = ["인기 영화", "주목할 영화", "현재 상영중", "곧 개봉할 영화"]
            
            cell.selectionStyle = .none
            cell.configureCell(data: homeData[indexPath.row].results)
            cell.titleLabel.text = titleList[indexPath.row]
            
            cell.delegate = self
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return UITableView.automaticDimension
        default: return 220
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 300
        default: return 200
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let vc = ViewController()
            vc.data = homeData[3].results[randomInt]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension HomeViewController: HomeMainTableViewCellDelegate {
    
    func didSelectItem(_ data: PopularResult) {
        let vc = ViewController()
        print("====", data)
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
}

protocol HomeMainTableViewCellDelegate : AnyObject {
    func didSelectItem(_ data: PopularResult)
}
