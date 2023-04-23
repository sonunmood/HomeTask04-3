//
//  TabBarController.swift
//  HomeTask04-3
//
//  Created by Sonun on 22/4/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    var viewController = ViewController()
    let favoriteViewController = FavoriteViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewController()
    }
    
    private func setupChildViewController() {
        
        let mainIcon = UIImage(systemName: "house")
        let favoriteIcon = UIImage(systemName: "star")
        
        viewControllers =  [generateNavigationController(rootViewController: viewController, image: mainIcon!), generateNavigationController(rootViewController: favoriteViewController, image: favoriteIcon!)]
        
    }
    
    
    
    func generateNavigationController(rootViewController: UIViewController, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        return navigationController
    }
}
