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
    
    let containerView = {
        let view = UIView()
        return view
    }()
    
    let backImageView = {
        let view = UIImageView()
        return view
    }()
    
    let blurImageView = {
        let view = UIVisualEffectView()
        view.effect = UIBlurEffect(style: .light)
        return view
    }()
    
    let posterImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let posterShadowView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 4) //햇빛 방향
        view.layer.shadowRadius = 4 //퍼짐의 정도
        view.layer.shadowOpacity = 0.3 //0~1 사이에서 투명도 조절
        view.clipsToBounds = false
        return view
    }()
    
    let gradationView = {
        let view = UIImageView()
        view.image = Image.posterBackground
        return view
    }()
    
    let playButton = {
        let view = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        if let originalImage = UIImage(systemName: "play.fill") {
            let scaledImage = originalImage.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25, weight: .light))
            view.setImage(scaledImage, for: .normal)
        }
        view.backgroundColor = .white
        view.tintColor = .black
        DispatchQueue.main.async {
            view.layer.cornerRadius = view.frame.width / 2
        }
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
        tableView.delegate = self
        tableView.dataSource = self

        callRequest(api: .trending(filter: .movie))
        callRequest(api: .popular)
        callRequest(api: .upcoming)
        callRequest(api: .now_playing)
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
        
        posterImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(posterImageViewClicked)))
        
        playButton.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func playButtonClicked() {
        
        let id = homeData[3].results[randomInt].id
        
        TmdbAPIManager.shared.requestConvertible(type: MovieVideoData.self, api: .videos(id: id)) { [weak self] response in
            switch response {
            case .success(let success):
                
                if !success.results.isEmpty {
                    
                    let vc = WebViewController()
                    vc.movieKey = success.results.first?.key ?? ""
                    self?.navigationController?.pushViewController(vc, animated: true)
                    
                } else {
                    self?.showAlert(title: "재생 가능한 영상이 없습니다.", massage: nil)
                }
                
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
    @objc func posterImageViewClicked() {
        let vc = OverviewViewController()
        vc.data = homeData[3].results[randomInt]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setHeaderPoster() {
        let randomMovie = homeData[3].results[randomInt].posterPath ?? ""
        let url = URL(string: URL.imageURL + randomMovie)
        posterImageView.kf.setImage(with: url)
        backImageView.kf.setImage(with: url)
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
                    self?.setHeaderPoster()
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
        tableView.tableHeaderView = containerView
        [backImageView, blurImageView, gradationView, posterShadowView, posterImageView].forEach { containerView.addSubview($0) }
        [playButton].forEach { posterImageView.addSubview($0) }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-100)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
            make.height.equalTo(650)
        }
        
        backImageView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        blurImageView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        gradationView.snp.makeConstraints { make in
            make.edges.equalTo(blurImageView)
        }
        
        posterShadowView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(posterShadowView)
        }
        
        playButton.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeMainTableViewCell.identifier, for: indexPath) as? HomeMainTableViewCell else { return UITableViewCell() }
        
        let titleList = ["인기 영화", "주목할 영화", "현재 상영중", "곧 개봉할 영화"]
        
        cell.selectionStyle = .none
        cell.configureCell(data: homeData[indexPath.row].results)
        cell.titleLabel.text = titleList[indexPath.row]
        
        cell.delegate = self
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = OverviewViewController()
        vc.data = homeData[3].results[randomInt]
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension HomeViewController: HomeMainTableViewCellDelegate {
    
    func didSelectItem(_ data: PopularResult) {
        let vc = OverviewViewController()
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
}

protocol HomeMainTableViewCellDelegate : AnyObject {
    func didSelectItem(_ data: PopularResult)
}
