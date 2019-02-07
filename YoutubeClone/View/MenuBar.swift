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
    
    var homeController: HomeController?
    
//    let imageNames = [FontAwesome.home,FontAwesome.hotjar, FontAwesome.youtube, FontAwesome.user]
    let imageNames = [
        ["name": FontAwesome.home, "style": 0],
        ["name": FontAwesome.hotjar, "style": 1],
        ["name": FontAwesome.youtube, "style": 1],
        ["name": FontAwesome.user, "style": 0]
    ]
    let fontAwesomeStyles = [FontAwesomeStyle.solid, FontAwesomeStyle.brands, FontAwesomeStyle.regular]
    
    
    func getFontAwesomeImage (name: FontAwesome, style: FontAwesomeStyle, color: UIColor, size: CGSize) -> UIImage {
        return UIImage.fontAwesomeIcon(name: name, style: style, textColor: color, size: size)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.init(rawValue: 0))
        
        setupHorizontalBar()
    }
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        // old school frame way to doing things
//        horizontalBarView.frame = CGRect.init(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        
        // new school way to laying out our views
        // in ios 9
        // need x, y, width, height constraints
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // -- 좌표를 가지고 수동으로 구현했던 코드
        // menuBar에서 scrollViewDidScroll을 사용해서 구현했기 때문에 더 이상 필요가 없음
//        let x = CGFloat(indexPath.item) * frame.width / 4
//        horizontalBarLeftAnchorConstraint?.constant = x
//
//        // sliding 에니메이션 구현
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
//
//        // 차이를 잘 모르겠음...;
////        UIView.animate(withDuration: 0.5) {
////            self.layoutIfNeeded()
////        }
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MenuCell else { return UICollectionViewCell() }
        
        cell.imageView.image = getFontAwesomeImage(
            name: imageNames[indexPath.item]["name"] as? FontAwesome ?? FontAwesome.home,
            style: fontAwesomeStyles[imageNames[indexPath.item]["style"] as? Int ?? 0],
            color: UIColor.black,
            size: CGSize(width: 28, height: 28)
        )
        cell.imageView.highlightedImage = getFontAwesomeImage(
            name: imageNames[indexPath.item]["name"] as? FontAwesome ?? FontAwesome.home,
            style: fontAwesomeStyles[imageNames[indexPath.item]["style"] as? Int ?? 0],
            color: UIColor.white,
            size: CGSize(width: 28, height: 28)
        )
        
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
    
//    override var isHighlighted: Bool {
//        didSet {
//
//    }
    
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
