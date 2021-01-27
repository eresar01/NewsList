//
//  CustomButton.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 25.01.21.
//

import UIKit

class CustomView: UIView {

    var imageName : ImageName
    //initialization code
    init(frame: CGRect, imageName : ImageName) {
        self.imageName = imageName
        super.init(frame: frame)
        makeView(frame: frame, imageName: imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //create views
    func makeView(frame : CGRect, imageName : ImageName) {
        let constreit : CGFloat = 12
        let imageSize = CGSize(width: frame.width - (2 * constreit), height: frame.height - (2 * constreit))
        let imageOrigin = CGPoint(x:  constreit, y:  constreit)
        let image = UIImageView(frame: CGRect(origin: imageOrigin, size: imageSize))
        image.image = UIImage(systemName: imageName.rawValue)
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        self.backgroundColor = .purple
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.addShadow()
        self.addSubview(image)
    }
}
//enum for getting names of images
enum ImageName : String {
    case photo
    case video
    case xmark
}
