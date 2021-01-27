//
//  NewsTableViewCell.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 23.01.21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var shortNews : ShortNews?
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var isLookedImage: UIImageView!
    @IBOutlet weak var lookedEffectView: UIVisualEffectView!
    
    @IBOutlet weak var dateView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //set value to properties
    func defaultData(shortNews : ShortNews) {
        self.titleLabel.text = shortNews.title
        self.categoryLabel.text = shortNews.category
        self.coverImageView.showImage(url: shortNews.coverPhotoUrl)
        self.lookedEffectView.isHidden = !shortNews.isLooked
        self.blurEffect(blurView: self.lookedEffectView)
        self.dateLabel.text? = Date().showDateFromString(timeStep: shortNews.date)
    }
    //add blur to view
    func blurEffect(blurView: UIVisualEffectView) {
        blurView.layer.cornerRadius = blurView.frame.height / 2
        blurView.layer.borderWidth = 2
        blurView.layer.borderColor = UIColor.white.cgColor
        blurView.layer.masksToBounds = false
        blurView.clipsToBounds = true
    }
    
}
