//
//  AppDelegate.swift
//  Grand
//
//  Created by MorsyElsokary on 21/07/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setMainInterface()
        return true
    }
    
    private func setMainInterface() {
        
        let mainVC = HomeViewController(
            presenter: HomePresenter(
                networkService: FilterdNewsService(
                    networkServices: NetworkService())))
        
        let headlineVC = HeadLinesViewController(
            headlinesPresenter: HeadLinesPresenter(
                headlineService: HeadLinesService()))
        
        let navigation = UINavigationController(
            rootViewController: headlineVC)
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)

        window!.rootViewController = navigation
        window!.makeKeyAndVisible()
    }
}

