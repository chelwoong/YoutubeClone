//
//  MenuBar.swift
//  YoutubeClone
//
//  Created by woong on 18/01/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit
import FontAwesome_swift

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var cellId = "cellId"
    
    let imageNames = ["home", "hotjar","youtube", "user"]
    
    func getFontAwesomeImage (name: String) -> UIImage {
        switch name {
        case "home":
            return UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: .black, size: CGSize(width: 28, height: 28))
        case "hotjar":
            return UIImage.fontAwesomeIcon(name: .hotjar, style: .brands, textColor: .black, size: CGSize(width: 28, height: 28))
        case "youtube":
            return UIImage.fontAwesomeIcon(name: .youtube, style: .brands, textColor: .black, size: CGSize(width: 28, height: 28))
        case "user":
            return UIImage.fontAwesomeIcon(name: .user, style: .solid, textColor: .black, size: CGSize(width: 28, height: 28))
        default:
            return UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: .black, size: CGSize(width: 28, height: 28))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MenuCell else { return UICollectionViewCell() }
        
        cell.imageView.image = getFontAwesomeImage(name: imageNames[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implement")
    }
}

class MenuCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
//            imageView.highlightedImage = isHighlighted ? UIImage.fontAwesomeIcon(name: , style: self, textColor: self, size: self) : UIImage.fontAwesomeIcon(name: self, style: self, textColor: self, size: self)
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: .black, size: CGSize(width: 28, height: 28))

        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
