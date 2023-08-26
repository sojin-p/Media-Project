//
//  IntroViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/26.
//

import UIKit
import SnapKit

class IntroViewController: UIPageViewController {
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var list: [UIViewController] = [FirstViewController(), SecondViewController(), ThirdViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        
        delegate = self
        dataSource = self
        
        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true)

    }

}

//MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension IntroViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    //before
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : list[previousIndex]
        
    }
    
    //after
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        
        return nextIndex >= list.count ? nil : list[nextIndex]
        
    }
    
    //page control
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else { return 0 }
        return index
    }
}

//MARK: - IntroClass
class FirstViewController: UIViewController {
    
    let skipButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(skipButton)
        setWhiteCapsuleButton(button: skipButton, title: "건너뛰기", size: .mini)
        setSkipButtonConstraints(button: skipButton)
        
        skipButton.addTarget(self, action: #selector(skipAndStartButtonClicked), for: .touchUpInside)
        
        view.backgroundColor = .blue
    }
}

class SecondViewController: UIViewController {
    
    let skipButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(skipButton)
        setWhiteCapsuleButton(button: skipButton, title: "건너뛰기", size: .mini)
        setSkipButtonConstraints(button: skipButton)
        
        skipButton.addTarget(self, action: #selector(skipAndStartButtonClicked), for: .touchUpInside)
        
        view.backgroundColor = .yellow
    }
}

class ThirdViewController: UIViewController {
    
    let skipButton = UIButton()
    let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(skipButton)
        view.addSubview(startButton)
        
        setWhiteCapsuleButton(button: skipButton, title: "건너뛰기", size: .mini)
        setSkipButtonConstraints(button: skipButton)
        
        setWhiteCapsuleButton(button: startButton, title: "시작하기", size: .large)
        startButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        skipButton.addTarget(self, action: #selector(skipAndStartButtonClicked), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(skipAndStartButtonClicked), for: .touchUpInside)
        
        view.backgroundColor = .systemPink
    }
}

extension UIViewController {
    
    @objc func skipAndStartButtonClicked() {
        print("클릭됨")
    }
    
}
