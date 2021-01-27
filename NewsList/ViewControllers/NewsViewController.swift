//
//  NewsViewController.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 24.01.21.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var dataMeneger = DataMeneger()
    var newsData: MetaCoreData!
    
    var photoButton: CustomView?
    var videoButton: CustomView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataMeneger.changeIsLooked(id: newsData.date)
        self.propertesDefaultData()
        self.navigationItem.title = "News"
    }
    //setting values to properties
    func propertesDefaultData() {
        coverImageView.showImage(url: newsData.coverPhotoUrl!)
        titleLabel.text = newsData.title
        categoryLabel.text = newsData.category! + " | " + dateFormatTime(date: Date(timeIntervalSince1970: TimeInterval(newsData.date)))
        bodyLabel.text = newsData.body?.HTMLconvert()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //add animation to custom views
        photoButton?.animatonHiddenButton()
        videoButton?.animatonHiddenButton()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //remove custom views from window
        photoButton?.removeFromSuperview()
        videoButton?.removeFromSuperview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addButtons(data: newsData)
    }
    
    func dateFormatTime(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy, hh:mm"
        return dateFormatter.string(from: date)
    }
//add custim views as buttons to window
    func addButtons(data : MetaCoreData) {
        let parentSize = self.view.frame
        let navigationBarheight: CGFloat = 136
        let constreit: CGFloat = 16
        let buttonHeight: CGFloat = 50
        
        var window: UIWindow? {
                guard let scene = UIApplication.shared.connectedScenes.first,
                      let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                      let window = windowSceneDelegate.window else {
                    return nil
                }
                return window
            }
        
        //Photo
        if let photoGallery = data.gallery, photoGallery.count > 0 {
            let photoViewFrame = CGRect(x: parentSize.maxX - (buttonHeight + constreit),
                                        y: navigationBarheight + constreit,
                                        width: buttonHeight,
                                        height: buttonHeight)
            photoButton = CustomView(frame: photoViewFrame, imageName: .photo)
            photoButton?.tapGestureRecognizersOfView(selectedView: #selector(photoViewAction), target: self)
            window?.addSubview(photoButton!)
            photoButton?.animatonShowButton()
        }
        
        //Video
        if let video = data.video, video.count > 0 {
            let videoViewFrame = CGRect(x: parentSize.maxX - (buttonHeight + constreit),
                                        y: navigationBarheight + buttonHeight + (2 * constreit),
                                        width: buttonHeight,
                                        height: buttonHeight)
            videoButton = CustomView(frame: videoViewFrame, imageName: .video)
            videoButton?.tapGestureRecognizersOfView(selectedView: #selector(videoViewAction), target: self)
            window?.addSubview(videoButton!)
            videoButton?.animatonShowButton()
        }
    }
    // MARK: methods for viewing custom views
    @objc func photoViewAction() {
        let galleryData = Array(self.newsData.gallery as! Set<GalleryCoreData>)
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
            nextVC.galleryData = galleryData
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @objc func videoViewAction() {
        
        let videoData = Array(self.newsData.video as! Set<VideoCoreData>)
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
            nextVC.videoData = videoData
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
