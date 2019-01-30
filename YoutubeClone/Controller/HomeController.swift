//
//  ViewController.swift
//  YoutubeClone
//
//  Created by woong on 18/01/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit
import FontAwesome_swift

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    var videos: [Video] = {
//        var woongsChannel = Channel.init(
//            name: "woongswoongswoongswoongsIsBestVideo!",
//            profileImageName: "bg13"
//        )
//
//        var blankVideo = Video.init(thumbnailImageName: "bg8", title: "Youtube cloning", numberOfViews: 123123123, uploadDate: nil, channel: woongsChannel, duration: 200)
//
//        var woongVideo = Video.init(thumbnailImageName: "woongtube Awesome!!", title: "bg10", numberOfViews: 998923899232, uploadDate: nil, channel: woongsChannel, duration: 200)
//
//        return [blankVideo, woongVideo]
//    }()
    
    var videos: [Video]?
    var channel: Channel?
    
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent // .default
//    }
    
    func fetchVideos() {
        // set up URL request
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") else {
            print("Error: cannot create URL")
            return
        }
//        let urlRequest = URLRequest(url: url)
        
        // set up Session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("dataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()
                self.videos = try decoder.decode([Video].self, from: data)
//                self.channel = try decoder.decode(Channel.self, from: data)
//                print(videoResponse)
                
                
            } catch(let err) {
                print(err.localizedDescription)
            }
            
        }
        dataTask.resume()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchVideos()
        
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
        setupNavBarButtons()
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage.fontAwesomeIcon(name: .search, style: .solid, textColor: .white, size: CGSize(width: 25, height: 25)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage.fontAwesomeIcon(name: .ellipsisV, style: .solid, textColor: .white, size: CGSize(width: 25, height: 25)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton,  searchBarButtonItem]
    }
    
    @objc func handleSearch() {
        
    }
    
    @objc func handleMore() {
        print(123)
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
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? VideoCell else { return VideoCell() }
        
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 16:9 ratio
        let height = (view.frame.width - 16 - 16) * 9 / 16
        // userprofileImage까지 다 포함시킨 16:9 비율을 유지하기 위해서
        // 탑 마진 16 + 바텀 마진(8), userprofileImage(44), 그밑에 바텀마진(16) 다 포함
        return CGSize.init(width: view.frame.width, height: height + 16 + 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

