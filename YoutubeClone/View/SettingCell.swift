//
//  SettingCell.swift
//  YoutubeClone
//
//  Created by woong on 30/01/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit
import FontAwesome_swift

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray :  UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white :  UIColor.black
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let image = setting?.image {
                iconImageView.image = image
            }
            
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.fontAwesomeIcon(name: .cog, style: .solid, textColor: .black, size: CGSize(width: 15, height: 15)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(iconImageView)
        addSubview(nameLabel)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    
}
