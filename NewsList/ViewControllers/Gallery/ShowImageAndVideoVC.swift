//
//  showImageAndVideoVC.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 26.01.21.
//

import UIKit
import youtube_ios_player_helper

class ShowImageAndVideoVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var webView: YTPlayerView!
    var imageURL = ""
    var youtubeId = ""
    var pageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .appColor
        
        showView()
    }
    
    //shows image or video based on data
    func showView() {
        if imageURL.isEmpty {
            imageView.isHidden = true
            webView.backgroundColor = .appColor
            webView.delegate = self
            webView.load(withVideoId: youtubeId, playerVars: ["playsinline": "1"])
            
        } else {
            webView.isHidden = true
            self.imageView.showImage(url: imageURL)
        }
    }
}

extension ShowImageAndVideoVC: YTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return .appColor
    }
}
