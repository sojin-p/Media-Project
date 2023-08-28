//
//  DetailViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import UIKit

class DetailViewController: BaseViewController {

    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    let sectionTitleList = ["OverView", "Cast"]
    var isExpand: Bool = false
    var movie: Result?
    var cast: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func callRequest(id: Int) {
        TmdbAPIManager.shared.callCreditRequest(id: id) { cast in
            self.cast = cast
            self.detailTableView.reloadData()
        }
    }
    
    override func configureView() {
        super.configureView()
        
        guard let movie else { return }
        
        title = "출연/제작"
        
        titleLabel.text = movie.title
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        let backdrop = URL(string: URL.imageURL + (movie.backdropPath ?? ""))
        backdropImageView.kf.setImage(with: backdrop)
        backdropImageView.contentMode = .scaleAspectFill
        
        let poster = URL(string: URL.imageURL + (movie.posterPath ?? ""))
        posterImageView.kf.setImage(with: poster)
        posterImageView.contentMode = .scaleAspectFill
        
//        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        setNib()
        callRequest(id: movie.id)
    }
    
    func setNib() {
        let castNib = UINib(nibName: CastTableViewCell.identifier, bundle: nil)
        detailTableView.register(castNib, forCellReuseIdentifier: CastTableViewCell.identifier)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleList[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return cast.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            guard let detailCell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as? DetailTableViewCell else { return UITableViewCell() }
            
            detailCell.overviewLabel.text = movie?.overview
            
            if isExpand {
                detailCell.expandImageView.image = UIImage(systemName: "chevron.up")
                detailCell.overviewLabel.numberOfLines = 0
            } else {
                detailCell.expandImageView.image = UIImage(systemName: "chevron.down")
                detailCell.overviewLabel.numberOfLines = 2
            }
            
            return detailCell
            
        case 1:
            guard let castCell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            
            DispatchQueue.main.async {
                castCell.castTitleLabel.text = self.cast[indexPath.row].castTitle
                
                let profile = URL(string: self.cast[indexPath.row].profileURLString)
                castCell.castImageView.kf.setImage(with: profile)
                castCell.castImageView.contentMode = .scaleAspectFill
            }
            
            return castCell
            
        default:
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0, isExpand {
            return UITableView.automaticDimension
        } else {
            return 90
        }
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            isExpand.toggle()
        }
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        
    }
}
