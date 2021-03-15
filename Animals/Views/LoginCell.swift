//
//  LoginCell.swift
//  Animals
//
//  Created by Kevin on 9/22/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class LoginCell: BaseCell {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Go", for: .normal)
        button.backgroundColor = Colors.orange
        button.addTarget(self, action: #selector(goToHomeController), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        return button
    }()
    
    let imageBackground: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "how_it_works")
        return iv
    }()
    
    override func setupViews() {
        add(imageBackground, button)

        _ = imageBackground.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        imageBackground.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        _ = button.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: 200, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 38)
        
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    @objc func goToHomeController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = MainNavigationController()
    }
}

