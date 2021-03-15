//
//  MainNavigationController.swift
//  Animals
//
//  Created by Kevin on 9/22/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        let homeController = HomeController()
        
        let isLoggedIn = true
        
        if isLoggedIn {
            viewControllers = [homeController]
        } else {
            _ = perform(#selector(showPagesController), with: nil, afterDelay: 0.1)
        }
        
    }
    
    @objc func showPagesController() {
        let viewController = TourController()
        
        present(viewController, animated: true, completion: {
            
        })
    }
}


