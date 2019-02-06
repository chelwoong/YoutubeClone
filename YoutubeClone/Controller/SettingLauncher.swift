//
//  SettingLauncher.swift
//  YoutubeClone
//
//  Created by woong on 30/01/2019.
//  Copyright © 2019 woong. All rights reserved.
//

//let policyAction: UIAlertAction
//        policyAction = UIAlertAction(title: "Terms & privacy policy", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
//            self.viewDidAppear(true)
//        })
//        let policyImage = UIImage.fontAwesomeIcon(name: .lock, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        policyAction.setValue(policyImage, forKey: "image")
//
//        let feedbackAction: UIAlertAction
//        feedbackAction = UIAlertAction(title: "Send Feedback", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
//            self.viewDidAppear(true)
//        })
//        let feedbackImage = UIImage.fontAwesomeIcon(name: .exclamationTriangle, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        feedbackAction.setValue(feedbackImage, forKey: "image")
//
//        let helpAction: UIAlertAction
//        helpAction = UIAlertAction(title: "Help", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
//            self.viewDidAppear(true)
//        })
//        let helpImage = UIImage.fontAwesomeIcon(name: .questionCircle, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        helpAction.setValue(helpImage, forKey: "image")
//
//        let swtichAccountAction: UIAlertAction
//        swtichAccountAction = UIAlertAction(title: "Switch Account", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
//            self.viewDidAppear(true)
//        })
//        let AccountImage = UIImage.fontAwesomeIcon(name: .userCircle, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        swtichAccountAction.setValue(AccountImage, forKey: "image")
//

import UIKit

class Setting: NSObject {
    let name: String
    let image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}

class SettingLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        let settingImage = UIImage.fontAwesomeIcon(name: .cog, style: .solid, textColor: .black, size: CGSize(width: 15, height: 15)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let policyImage = UIImage.fontAwesomeIcon(name: .lock, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let feedbackImage = UIImage.fontAwesomeIcon(name: .exclamationTriangle, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let helpImage = UIImage.fontAwesomeIcon(name: .questionCircle, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let accountImage = UIImage.fontAwesomeIcon(name: .userCircle, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let cancelImage = UIImage.fontAwesomeIcon(name: .ban, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)

        return [Setting(name: "Setting", image: settingImage),
                Setting(name: "Terms & privacy policy", image: policyImage),
                Setting(name: "Send Feedback", image: feedbackImage),
                Setting(name: "Help", image: helpImage),
                Setting(name: "Switch Account", image: accountImage),
                Setting(name: "Cancel", image: cancelImage),
        ]
    }()
    
    var homeController: HomeController? = HomeController()
    
    
    @objc func showSettings() {
        // show menu
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            blackView.frame = window.frame
            
            window.addSubview(collectionView)
            collectionView.backgroundColor = UIColor.white
//            let height: CGFloat = 300
            let height: CGFloat = CGFloat(settings.count + 1) * cellHeight
            let y = window.frame.height - height
            // animation 효과를 주기 위해 시작점을 화면 맨 밑으로
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            // add animation
            blackView.alpha = 0
            
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss(setting: NSObject) {
        UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed: Bool) in
            if setting is Setting {
                guard let setting = setting as? Setting else { return }
                
                if setting.name != "Cancel" {
                    self.homeController?.showControllerForSettings(setting)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SettingCell else { return SettingCell() }
        
        let setting = settings[indexPath.item]
        cell.setting = setting

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
    }
    
    override init() {
        super.init()
        // start doing something maybe...
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}
