//
//  PageCell.swift
//  Animals
//
//  Created by Kevin on 9/22/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class PageCell: BaseCell {
    
    var page: Page? {
        
        didSet {
            guard let page = page else { return }
            
            imageView.image = UIImage(named: page.imageName)
            
            let attrText1 = NSMutableAttributedString(string: page.message, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light), NSAttributedStringKey.foregroundColor: UIColor.black])
            
            let attrText2 = NSMutableAttributedString(string: "\n\n\(page.author)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold), NSAttributedStringKey.foregroundColor: UIColor.black])
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            attrText1.append(attrText2)
            
            let length = attrText1.string.count
            attrText1.addAttributes([NSAttributedStringKey.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: length))
            
            textView.attributedText = attrText1
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.textColor = Colors.gray
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.orange
        return view
    }()
    
    override func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)
        
        imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        
        textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        lineSeparatorView.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
