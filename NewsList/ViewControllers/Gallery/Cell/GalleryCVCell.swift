//
//  GalleryCVCell.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 26.01.21.
//

import UIKit

class GalleryCVCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.frame.size = self.frame.size
    }
    //show url-based data
    func addImageData(data : GalleryCoreData) {
        imageView.showImageBase(url: data.contentUrl!)
    }
    
    func addImageData(data : VideoCoreData) {
        imageView.showImageBase(url: data.thumbnailUrl!)
    }
    
}
