//
//  TabBarController.swift
//  MyShopping
//
//  Created by 전준영 on 6/14/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = Color.myShopMainColor
        tabBar.unselectedItemTintColor = Color.gray
        
        let search = SearchViewController()
        let nav1 = UINavigationController(rootViewController: search)
        nav1.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let like = LikeListViewController()
        let nav2 = UINavigationController(rootViewController: like)
        nav2.tabBarItem = UITabBarItem(title: "좋아요", image: UIImage(systemName: "hand.thumbsup.fill"), tag: 0)
        
        let setting = SettingViewController()
        let nav3 = UINavigationController(rootViewController: setting)
        nav3.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
    
}
