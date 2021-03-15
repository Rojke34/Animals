//
//  DetailController.swift
//  Animals
//
//  Created by Kevin Rojas on 12/11/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: CustomImageView!
    @IBOutlet weak var genderLabel: UILabel!
    
    var pet: Pet?
    
    let bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.orange
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImage.layer.shadowColor = UIColor.black.cgColor
        photoImage.layer.shadowOffset = CGSize(width: 0, height: 5)
        photoImage.layer.shadowOpacity = 0.2
        photoImage.layer.shadowRadius = 1
        
        guard let animalInfo = pet else { return }

        print(animalInfo.image)
        
        nameLabel.text = animalInfo.name
        photoImage.loadImageUsingUrlString(urlString: animalInfo.image)
        genderLabel.text = animalInfo.gender
    }
}
