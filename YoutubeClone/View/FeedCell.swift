//
//  FeedCell.swift
//  YoutubeClone
//
//  Created by woong on 07/02/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
    var cellId = "cellId"
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideos { (videos:[Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
            
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        
        self.backgroundColor = UIColor.green
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? VideoCell else { return VideoCell() }
        
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 16:9 ratio
        let height = (frame.width - 16 - 16) * 9 / 16
        // userprofileImage까지 다 포함시킨 16:9 비율을 유지하기 위해서
        // 탑 마진 16 + 바텀 마진(8), userprofileImage(44), 그밑에 바텀마진(16) 다 포함
        return CGSize.init(width: frame.width, height: height + 16 + 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        
        videoLauncher.showVideoPlayer()
    }
    
    
}
