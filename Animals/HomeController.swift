//
//  HomeController.swift
//  Animals
//
//  Created by Kevin on 9/22/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol HomeControllerDelegate {
    func goToDetail(pet: Pet)
}

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeControllerDelegate {
    let dogCellId = "dogId"
    let catCellId = "catId"
    
    lazy var wishList: UIBarButtonItem = {
        let menuBarButton: UIButton = UIButton(type: UIButtonType.custom)
        menuBarButton.setImage(UIImage(named: "reload")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        menuBarButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        menuBarButton.addTarget(self, action: #selector(reload), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: menuBarButton)
        return barButton
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Colors.gray
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    var cats: [Pet] = []
    var dogs: [Pet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animals"
        
        navigationItem.rightBarButtonItem = wishList
        view.backgroundColor = Colors.gray
        
        view.addSubview(collectionView)
        
        view.addSubview(menuBar)
        
        //use autolayout instead
        menuBar.anchorWithConstantsToTop(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        menuBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        collectionView.anchorWithConstantsToTop(menuBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
        setupCollectionView()
        
        fetchData()
    }
    
    @objc func reload() {
        fetchData()
    }
    
    func fetchData() {
        dogs.removeAll()
        cats.removeAll()
        
        Alamofire.request("http://10.10.10.15:8000/animals").responseJSON { response in
            if let data = response.result.value {
                let json = JSON(data)
                
                for item in json.arrayValue {
                    if item["category"] == "Dog" {
                        let dog = Pet(name: item["full_name"].stringValue, gender: item["gender"].stringValue, image: item["photo"].stringValue)
                        self.dogs.append(dog)
                    } else {
                        let cat = Pet(name: item["full_name"].stringValue, gender: item["gender"].stringValue, image: item["photo"].stringValue)
                        self.cats.append(cat)
                    }
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView.register(PetCellController.self, forCellWithReuseIdentifier: dogCellId)
        collectionView.register(PetCellController.self, forCellWithReuseIdentifier: catCellId)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollToMenuIndex(_ menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: catCellId, for: indexPath) as! PetCellController
        cell.homeControllerDeletage = self
        cell.data = indexPath.item == 0 ? cats : dogs
        
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: collectionView.frame.size.height)
    }
    
    //MARK: Delegate functions
    func goToDetail(pet: Pet) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dc = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailController
        dc.pet = pet
        
        navigationController?.pushViewController(dc, animated: true)
    }
}
