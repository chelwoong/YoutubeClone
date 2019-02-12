//
//  VideoLauncher.swift
//  YoutubeClone
//
//  Created by woong on 08/02/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit
import AVFoundation
import FontAwesome_swift

class VideoPlayerView: UIView {
    
    var player: AVPlayer?
    var isPlaying = false
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let pausePlayButton: UIButton = {
        let button = UIButton(type: .custom)
        let pauseImage = UIImage.fontAwesomeIcon(name: .pause, style: .solid, textColor: UIColor.white, size: CGSize(width: 50, height: 50))
        button.setImage(pauseImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)

        return button
    }()
    
    @objc func handlePause() {
        
        if isPlaying {
            player?.pause()
            let image = UIImage.fontAwesomeIcon(name: .play, style: .solid, textColor: UIColor.white, size: CGSize(width: 50, height: 50))
            pausePlayButton.setImage(image, for: .normal)
        } else {
            player?.play()
            let image = UIImage.fontAwesomeIcon(name: .pause, style: .solid, textColor: UIColor.white, size: CGSize(width: 50, height: 50))
            pausePlayButton.setImage(image, for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()

        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50)
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50)
        
        backgroundColor = UIColor.black
    }
    
    
    
    private func setupPlayerView() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/clone-c033b.appspot.com/o/%E1%84%87%E1%85%A1%E1%86%AB%E1%84%8D%E1%85%A1%E1%86%A8%E1%84%87%E1%85%A1%E1%86%AB%E1%84%8D%E1%85%A1%E1%86%A8%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%8B%E1%85%B3%E1%86%AB%E1%84%87%E1%85%A7%E1%86%AF.mp4?alt=media&token=e2c3103b-3c02-403e-8928-b82cf9d6fd67"
        
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // this is when the player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            pausePlayButton.isHidden = false
            isPlaying = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        print("Showing Video with animation....")
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 100, y: keyWindow.frame.height - 100, width: 100, height: 100)
            
            // 16 x 9 is the aspect ratio of all HD videos
            let videoPlayHeight = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoPlayHeight)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { (complitedAnimation) in
                // prefersStatusBarHidden false
            }
        }
    }
    
}
