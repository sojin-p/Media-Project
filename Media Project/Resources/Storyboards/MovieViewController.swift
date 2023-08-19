//
//  MovieViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/19.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet var movieCollectionView: UICollectionView!
    
    var similarList: MovieTrend = MovieTrend(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        TmdbAPIManager.shared.callSimilarRequset(id: 976573) { data in
            self.similarList = data
            print(self.similarList.results)
            self.movieCollectionView.reloadData()
        }

    }

}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarList.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell()}

        if indexPath.section == 0 {
            let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(similarList.results[indexPath.item].posterPath ?? "")"
            cell.movieImageView.kf.setImage(with: URL(string: url))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderMovieCollectionReusableView.identifier, for: indexPath) as? HeaderMovieCollectionReusableView else { return UICollectionReusableView() }
            
            view.headerLabel.text = "테스트 섹션"
            
            return view
            
        } else {
            return UICollectionReusableView()
        }
    }
    
}

extension MovieViewController {
    
    func setUI() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        setCollectionViewLayout()
        setNib()
    }
    
    func setNib() {
        let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        movieCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        let headerNib = UINib(nibName: HeaderMovieCollectionReusableView.identifier, bundle: nil)
        movieCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderMovieCollectionReusableView.identifier)
    }
    
    func setCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        layout.itemSize = CGSize(width: width / 3, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        layout.scrollDirection = .vertical
        
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 30)
        
        movieCollectionView.collectionViewLayout = layout
    }
    
}
