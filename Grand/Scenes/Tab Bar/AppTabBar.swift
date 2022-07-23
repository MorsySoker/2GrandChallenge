//
//  AppTabBar.swift
//  Grand
//
//  Created by MorsyElsokary on 23/07/2022.
//

import UIKit
    // fx-991es

class AppCustomTabBarController: UITabBarController {
    
    enum TabBarItems : CaseIterable {
        case home
        case headlines
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let appearance = UITabBarItem.appearance(whenContainedInInstancesOf: [AppCustomTabBarController.self])
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray],
                                          for: .normal)
        
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray],
                                          for: .selected)
        UITabBar.appearance().barTintColor = UIColor.darkGray
        setUpTabBarComponent()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpView(){
        let tabGradientView = UIView(frame: tabBar.bounds)
        tabGradientView.backgroundColor = UIColor.white
        
        tabGradientView.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(tabGradientView)
        tabBar.sendSubviewToBack(tabGradientView)
        tabGradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabGradientView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabGradientView.layer.shadowRadius = 4.0
        tabGradientView.layer.shadowColor = UIColor.gray.cgColor
        tabGradientView.layer.shadowOpacity = 0.3
        tabBar.clipsToBounds = false
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }

   private func setUpTabBarComponent(){
        self.viewControllers =  TabBarItems.allCases.map({
            let viewController = viewControllerForTabBarItems($0)
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.setNavigationBarHidden(true, animated: true)
            return navigationController
        })

    }
    
    func viewControllerForTabBarItems(_ tabs : TabBarItems) -> UIViewController {

        switch tabs {
        case .home:
            let homeVC = HomeViewController(
                presenter: HomePresenter(
                    networkService: FilterdNewsService(
                        networkServices: NetworkService())))
            homeVC.tabBarItem = setUpTabBarItemUI(for: tabs)
            return homeVC
            
        case .headlines:
            let headlineVC = HeadLinesViewController(
                headlinesPresenter: HeadLinesPresenter(
                    headlineService: HeadLinesService()))
            headlineVC.tabBarItem = setUpTabBarItemUI(for: tabs)
            return headlineVC
        }
    }
    
    
    func setUpTabBarItemUI(for tabBarItem : TabBarItems) -> UITabBarItem {
        var tab : UITabBarItem
    
        switch tabBarItem {
            
        case .home:
            tab = .init(
                title: "Home",
                image: UIImage(systemName: "house"),
                selectedImage: UIImage(systemName: "house"))
            
        case .headlines:
            tab = .init(
                title: "HeadLines",
                image: UIImage(
                    systemName: "list.dash.header.rectangle"),
                selectedImage: UIImage(
                    systemName: "list.dash.header.rectangle"))
        }
        
        tabBar.selectedItem?.badgeColor = UIColor.red
        tabBar.tintColor = UIColor.red
        tabBar.unselectedItemTintColor = UIColor.gray
       
        return tab
    }
}
