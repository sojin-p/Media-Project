//
//  ViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/11.
//

import UIKit

class TrendViewController: UIViewController {

    @IBOutlet var trendTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "타이틀"
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        trendTableView.estimatedRowHeight = 380
        trendTableView.rowHeight = UITableView.automaticDimension
        
        let nib = UINib(nibName: TrendTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: TrendTableViewCell.identifier)
    }


}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
}
