//
//  BaseCell.swift
//  Animals
//
//  Created by Kevin on 9/26/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() { }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
