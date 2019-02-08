//
//  SubscriptionCell.swift
//  YoutubeClone
//
//  Created by woong on 08/02/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
