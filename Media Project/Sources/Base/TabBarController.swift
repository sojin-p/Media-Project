//
//  TabBarController.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/11.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let homeVC = {
        let vc = HomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        return nav
    }()

    private let trendVC = {
        let vc = TrendViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(title: "Trend", image: UIImage(systemName: "star"), tag: 1)
        return nav
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .lightGray
        setViewControllers([homeVC, trendVC], animated: true)

    }
    
}

