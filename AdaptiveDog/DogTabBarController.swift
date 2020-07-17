//
//  DogTabBarController.swift
//  Created 7/16/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import UIKit

class DogTabBarController: UITabBarController {

    let dogViewControllers: [(String, UIViewController)] = [
        ("Basic", BasicAdaptiveViewController())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(dogViewControllers.map { $0.1 }, animated: false)
        dogViewControllers.forEach {
            $1.tabBarItem.title = $0
            $1.view.backgroundColor = .white
        }
        
        
    }

}
