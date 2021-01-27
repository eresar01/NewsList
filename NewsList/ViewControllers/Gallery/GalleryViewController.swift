//
//  GalleryViewController.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 26.01.21.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var galleryData : [GalleryCoreData]?
    var videoData: [VideoCoreData]?
    let conteins : CGFloat = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.galleryCollectionView.register(UINib(nibName: "GalleryCVCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.galleryCollectionView.dataSource = self
        self.galleryCollectionView.delegate = self
        self.view.backgroundColor = .appColor
        self.galleryCollectionView.backgroundColor = .appColor
        self.navigationItem.title = videoData == nil ? "Gallery" : "Video"
    }
    
}
// MARK: collection view
extension GalleryViewController : UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let galleryData = galleryData {
            return galleryData.count
        }
        return  videoData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCVCell
        if let galleryData = galleryData {
            cell.addImageData(data: galleryData[indexPath.row])
            return cell
        }
        guard let videoData = videoData else { return cell }
        cell.addImageData(data: (videoData[indexPath.row]))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "GalleryPageViewController") as! GalleryPageViewController
            
            if let galleryData = self.galleryData {
                nextVC.galleryData = galleryData
            }
            if let videoData = self.videoData {
                nextVC.videoData = videoData
            }
            
            nextVC.pageCount = self.galleryData != nil ? self.galleryData?.count as! Int : self.videoData?.count as! Int
            nextVC.index = indexPath.row
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sizeInItem(viewItem: galleryCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
        return UIEdgeInsets(top: conteins, left: conteins, bottom: conteins, right: conteins)
    }
    
    func sizeInItem(viewItem:UICollectionView) -> CGSize {
        let widht = viewItem.layer.bounds.width
        let itemWidht = (widht - (conteins * 4)) / 3
        let itemHeight = itemWidht
        return CGSize(width: itemWidht, height: itemHeight)
    }

        // top or bottom
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return conteins
    }

    // right or left
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return conteins
    }
    
}
