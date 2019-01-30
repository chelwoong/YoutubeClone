//
//  SettingLauncher.swift
//  YoutubeClone
//
//  Created by woong on 30/01/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

class SettingLauncher: NSObject {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    
    @objc func showSettings() {
        // show menu
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            blackView.frame = window.frame
            
            blackView.addSubview(collectionView)
            collectionView.backgroundColor = UIColor.white
            let height: CGFloat = 200
            let y = window.frame.height - height
            // animation 효과를 주기 위해 시작점을 화면 맨 밑으로
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            // add animation
            blackView.alpha = 0
            
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
//            UIView.animate(withDuration: 0.5) {
//                self.blackView.alpha = 1
//
//                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
//            }
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
    }
    
    override init() {
        super.init()
        // start doing something maybe...
    }
}
