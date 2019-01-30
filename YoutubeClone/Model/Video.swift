//
//  Video.swift
//  YoutubeClone
//
//  Created by woong on 22/01/2019.
//  Copyright © 2019 woong. All rights reserved.
//

//"title": "Taylor Swift - I Knew You Were Trouble (Exclusive)",
//"number_of_views": 319644991,
//"thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_swift_i_knew_you_were_trouble.jpg",
//"channel": {
//    "name": "Taylor Fan Forever",
//    "profile_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_fan_forever_profile.jpg"
//},
//"duration": 210

import UIKit

 struct Video: Codable {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: Int?
    var uploadDate: Data?
    var channel: Channel
    var duration: Int
    
    enum CodingKeys: String, CodingKey {
        case title, channel, duration
        case thumbnailImageName = "thumbnail_image_name"
        case numberOfViews = "number_of_views"
        
    }
}

struct Channel: Codable {
    var name: String?
    var profileImageName: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImageName = "profile_image_name"
    }
}
