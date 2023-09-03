//
//  TrendTableViewCell.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import UIKit

enum MediaType {
    case all
    case movie
    case tv
    case person
}

class TrendTableViewCell: BaseTableViewCell {
    
    let releaseDateLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.textColor = .gray
        return view
    }()
    
    let genreLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let backView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.5
        view.clipsToBounds = false
        return view
    }()
    
    let posterBackView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    let posterImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let trendTitleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let overviewLabel = {
        let view = UILabel()
        view.textColor = .gray
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let detailLabel = {
        let view = UILabel()
        view.text = "자세히 보기"
        view.font = .boldSystemFont(ofSize: 12)
        return view
    }()
    
    let detailImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .black
        return view
    }()
    
    let originalTitleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .gray
        return view
    }()
    
    let genres = [ 28: "Action", 12: "Adventure", 16: "Animation", 35: "Comedy", 80: "Crime",
                    99: "Documentary", 18: "Drama", 10751: "Family", 14: "Fantasy", 36: "History",
                    27: "Horror", 10402: "Music", 9648: "Mystery", 10749: "Romance", 878: "Science Fiction",
                    10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western"
    ]
    
    func configureCell(row: TrendResult, type: MediaType) {
        
        if let genre = genres[row.genreIDS[0]] {
            genreLabel.text = "#\(genre)"
        }
        
        let url = URL(string: URL.imageURL + (row.backdropPath ?? ""))
        posterImageView.kf.setImage(with: url)
        overviewLabel.text = row.overview
        switch type {
        case .movie:
            releaseDateLabel.text = row.releaseDate
            trendTitleLabel.text = row.title
            originalTitleLabel.text = row.originalTitle
        case .tv:
            releaseDateLabel.text = row.firstAirDate
            trendTitleLabel.text = row.name
            originalTitleLabel.text = row.originalName
        default:
            print("기달")
        }
    }
    
    override func configureView() {
        
        let viewList = [[releaseDateLabel, genreLabel, backView], [posterImageView, trendTitleLabel, originalTitleLabel, overviewLabel, lineView, detailLabel, detailImageView]]
        
        viewList[0].forEach { contentView.addSubview($0) }
        backView.addSubview(posterBackView)
        viewList[1].forEach { posterBackView.addSubview($0) }
    
    }
    
    override func setConstraints() {
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(70)
            make.horizontalEdges.bottom.equalTo(contentView).inset(20)
            make.height.equalTo(contentView.snp.width).inset(20)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backView.snp.top).offset(-10)
            make.leading.equalTo(backView)
            make.height.equalTo(26)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(genreLabel.snp.top)
            make.height.equalTo(18)
            make.leading.equalTo(genreLabel)
        }

        posterBackView.snp.makeConstraints { make in
            make.edges.equalTo(backView)
        }

        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(posterBackView)
            make.height.equalTo(posterBackView.snp.height).multipliedBy(0.6)
        }

        trendTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(20)
        }
        
        trendTitleLabel.setContentHuggingPriority(.init(251), for: .horizontal)
        trendTitleLabel.setContentCompressionResistancePriority(.init(750), for: .horizontal)

        originalTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(trendTitleLabel)
            make.leading.equalTo(trendTitleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(20)
        }
        
        originalTitleLabel.setContentHuggingPriority(.init(250), for: .horizontal)
        originalTitleLabel.setContentCompressionResistancePriority(.init(749), for: .horizontal)

        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(originalTitleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(20)
        }

        lineView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(overviewLabel.snp.bottom).offset(12)
            make.height.equalTo(1)
        }

        detailImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalTo(lineView.snp.bottom).offset(12)
            make.trailing.bottom.equalToSuperview().inset(20)
        }

        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(lineView.snp.leading)
            make.bottom.equalTo(detailImageView.snp.bottom)
        }
        
    }
}
