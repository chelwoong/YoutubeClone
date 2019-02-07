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
    
    var videos: [Video]?
    var channel: Channel?
    
    func fetchVideos() {
        // set up URL request
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") else {
            print("Error: cannot create URL")
            return
        }
        
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
                
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
                
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
    
    lazy var settingLauncher: SettingLauncher = {
        let launcher = SettingLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleMore() {
        // show menu
        settingLauncher.showSettings()
        
//        showControllerForSettings()
    }
    
    func showControllerForSettings(_ setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        dummySettingsViewController.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }

//    @objc func handleMore() {
//        let alertController: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
//
//        let settingAction: UIAlertAction
//        settingAction = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
//            self.viewDidAppear(true)
//        })
//        let settingImage = UIImage.fontAwesomeIcon(name: .cog, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        settingAction.setValue(settingImage, forKey: "image")
//
//        let policyAction: UIAlertAction
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
//        let cancelAction: UIAlertAction
//        cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
//
//        alertController.addAction(settingAction)
//        alertController.addAction(policyAction)
//        alertController.addAction(feedbackAction)
//        alertController.addAction(helpAction)
//        alertController.addAction(swtichAccountAction)
//        alertController.addAction(cancelAction)
//
//        // 모달이 올라오는 애니메이션이 끝난 직후에 실행
//        self.present(alertController, animated: true, completion: {
//            print("Alert controller shown")
//        })
//    }
//
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
//        view.safeAreaLayoutGuide.topAnchor
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
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

