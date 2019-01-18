//
//  ViewController.swift
//  YoutubeClone
//
//  Created by woong on 18/01/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent // .default
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.contentInset = UIEdgeInsets.init(top: 50, left: 0, bottom: 0, right: 0)
        // scroll도 메뉴바 밑으로 내려줘야 함
        collectionView.scrollIndicatorInsets = UIEdgeInsets.init(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 16:9 ratio
        let height = (view.frame.width - 16 - 16) * 9 / 16
        // userprofileImage까지 다 포함시킨 16:9 비율을 유지하기 위해서
        // 탑 마진 16 + 바텀 마진(8), userprofileImage(44), 그밑에 바텀마진(16) 다 포함
        return CGSize.init(width: view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

