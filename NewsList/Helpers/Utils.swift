//
//  Utils.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 23.01.21.
//

import Foundation
import UIKit
import Kingfisher
import WebKit

// extension for showing image
extension UIImageView {
    
    func showImageBase(url : String) {
        if url != "" {
            let imageCache = [String:UIImage]()
            let urlString : String = url.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!
            
            let imgURL = NSURL(string: urlString)
            
            if let img = imageCache[urlString] {
                self.image = img
            }
            else if (imgURL != nil){
                
                let myCache = ImageCache(name: "cacheImage")
                let url = URL(string: urlString)!
                
                self.kf.setImage(with: url,
                                 options: [.targetCache(myCache)],
                                 progressBlock: nil
                                 )
            }
        }
        else {
            
            self.image = UIImage(named: "cacheImage")
        }
        
    }
    
    func showImage(url : String) {

        let url = URL(string: url)
        self.clipsToBounds = true
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 0)
            |> ResizingImageProcessor(referenceSize: self.bounds.size, mode: .aspectFill)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
                    
            ])
        {
            
            result in
            switch result {
            case .success(let value):
                let _ = value
            case .failure(let error):
                let _ = error
            }
        }
    }
}

//extension for converting date to string
extension Date {
    
    func showDateFromString(timeStep: Int64) -> String {
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSince1970: TimeInterval(timeStep))
        let date1 = calendar.startOfDay(for: date)
        let date2 = calendar.startOfDay(for: Date())
        let components = calendar.dateComponents([.second,.minute,.hour,.day,.weekOfMonth,.month,.year,.calendar], from: date1, to: date2)
        
        guard components.year == 0 else { return String(components.year!) + "Y"}
        guard components.month == 0 else { return String(components.month!) + "M"}
        guard components.weekOfMonth == 0 else { return String(components.weekOfMonth!) + "W"}
        guard components.day == 0 else { return String(components.day!) + "d"}
        guard components.hour == 0 else { return String(components.hour!) + "h" }
        guard components.minute == 0 else { return String(components.minute!) + "m"}
        guard components.second == 0 else { return String(components.second!) + "s"}
        
        return ""
    }
    
}


extension UIView {
    
    //method for adding shadow to views
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 3
        self.layer.shadowRadius = 3.0
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        
    }
    //method for adding action to views when being tapped
    func tapGestureRecognizersOfView(selectedView: Selector, target: UIViewController) {
        let viewAction = UITapGestureRecognizer(target: target, action: selectedView)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(viewAction)
    }
    //animation method for showing custom view
    func animatonShowButton() {
        self.alpha = 0
        self.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        })
    }
    //animation for hiding custom view
    func animatonHiddenButton() {
        self.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        })
    }
}

extension String {
    //method for converting html text to string
    
    func HTMLconvert() -> String {
        let htmlText = self
        let encodedData = htmlText.data(using: String.Encoding.utf8)!
        var attributedString: NSAttributedString

        do {
            attributedString = try NSAttributedString(data: encodedData, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
            return attributedString.string
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print(" HTMLconvert error")
        }
        return ""
    }
}
extension UIColor {
    //color for app
    open class var appColor: UIColor {
        return UIColor.purple
    }
}
