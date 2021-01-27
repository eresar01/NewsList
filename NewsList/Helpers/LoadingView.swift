//
//  LoadingView.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 27.01.21.
//

import UIKit

class LoadingView: UIView {
    
    let viewParent = UIWindow()
    let viewLoading = UIView()
    let effect = UIVisualEffectView()
    let activityIndekator = UIActivityIndicatorView()
    
       //method for showing view
    func show() {
        var window: UIWindow? {
                guard let scene = UIApplication.shared.connectedScenes.first,
                      let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                      let window = windowSceneDelegate.window else {
                    return nil
                }
                return window
            }
            
        effect.frame = viewParent.frame
        viewLoading.frame = viewParent.frame
        effect.effect = UIBlurEffect(style: .dark)
        viewLoading.addSubview(effect)
        activityIndekator.frame.size = CGSize(width: 50, height: 50)
        activityIndekator.center = viewLoading.center
        activityIndekator.color = .appColor
        viewLoading.addSubview(activityIndekator)
        activityIndekator.startAnimating()
        window?.addSubview(viewLoading)
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.viewLoading.alpha = 1
            }, completion: nil)
    }
    //method for dismissing view
    func dismiss() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.viewLoading.alpha = 1
        }) { (true) in
            self.activityIndekator.startAnimating()
            self.viewLoading.removeFromSuperview()
            self.activityIndekator.removeFromSuperview()
        }
    }
}

