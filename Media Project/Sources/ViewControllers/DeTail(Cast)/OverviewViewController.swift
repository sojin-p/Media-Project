//
//  ViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/11.
//

import UIKit
import Kingfisher

final class OverviewViewController: BaseViewController {
    
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
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.backgroundColor = .systemYellow
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "타이틀입니다"
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.numberOfLines = 0
        return view
    }()
    
    let originTitleLabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "원제 : 어쩌구저쩌구"
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.numberOfLines = 0
        return view
    }()
    
    let playButton = {
        let view = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.setImage(UIImage(systemName: "play.fill"), for: .normal)
        view.backgroundColor = .white
        view.tintColor = .black
        DispatchQueue.main.async {
            view.layer.cornerRadius = view.frame.width / 2
        }
        return view
    }()
    
    var data: PopularResult?
    var cast: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        setTableHeaderView()
        callCast()
    }
    
    func callCast() {

        guard let data else { return }
        
        TmdbAPIManager.shared.requestConvertible(type: CastData.self, api: .credits(id: data.id)) { [weak self] response in
            switch response {
            case .success(let success):
                self?.cast.append(contentsOf: success.cast)
                self?.tableView.reloadData()
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
    func setTableHeaderView() {
        guard let data else { return }
        
        let backdropUrl = URL(string: URL.imageURL + (data.backdropPath ?? ""))
        backdropImageView.kf.setImage(with: backdropUrl)
        
        let posterUrl = URL(string: URL.imageURL + (data.posterPath ?? ""))
        posterImageView.kf.setImage(with: posterUrl)
        
        titleLabel.text = data.title
        originTitleLabel.text = data.originalTitle
        
    }
    
    override func configureView() {
        view.addSubview(tableView)
        tableView.tableHeaderView = backdropImageView
        [alphaView, posterImageView, originTitleLabel, titleLabel, playButton].forEach { backdropImageView.addSubview($0) }
    }
    
    override func setConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-100)
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
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.4)
        }
        
        originTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView)
            make.leading.equalTo(posterImageView.snp.trailing).offset(15)
            make.trailing.equalTo(playButton.snp.leading).offset(-15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(originTitleLabel.snp.top).offset(-4)
            make.leading.trailing.equalTo(originTitleLabel)
        }
        
        playButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.trailing.equalTo(backdropImageView).offset(-20)
            make.bottom.equalTo(originTitleLabel.snp.bottom)
        }
    }
    
}

extension OverviewViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            
            if let data = self.data {
                cell.overviewLabel.text = data.overview
            }
            
            cell.selectionStyle = .none
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCastTableViewCell.identifier, for: indexPath) as? DetailCastTableViewCell else { return UITableViewCell() }
            
            if !cast.isEmpty {
                cell.configureCell(cast: cast)
            }
            
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
}
