//
//  HomeCell.swift
//  Animals
//
//  Created by Kevin on 9/22/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class PetCellController: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var homeControllerDeletage: HomeControllerDelegate?
    
    var data: [Pet]? {
        didSet {
            guard let cat = data else { return }

            pets = cat

            collectionView.reloadData()
        }
    }

    var pets = [Pet]()
        
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Colors.gray
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setupViews() {
        addSubview(collectionView)
        
        collectionView.anchorToTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        collectionView.register(PetCell.self, forCellWithReuseIdentifier: "catId")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catId", for: indexPath) as! PetCell
        
        cell.pets = pets[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 133)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if homeControllerDeletage != nil {
            homeControllerDeletage?.goToDetail(pet: pets[indexPath.row])
        }
    }
    
}

class PetCell: BaseCell {
    
    var pets: Pet? {
        didSet {
            guard let pet = pets else { return }
        
            imageView.loadImageUsingUrlString(urlString: pet.image)
            labelView.text = pet.name
        }
    }
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let labelView: UILabel = {
        let label = UILabel()
        label.textColor = Colors.orange
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let iconView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "dog-pawprint")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    override func setupViews() {
        backgroundColor = Colors.lightGray
        
        addSubview(imageView)
        addSubview(labelView)
        addSubview(iconView)
        
        _ = imageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2).isActive = true
        
        _ = labelView.anchor(topAnchor, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 40, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = iconView.anchor(labelView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: frame.size.width / 4 - 10 , widthConstant: 20, heightConstant: 18)
        iconView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
}

