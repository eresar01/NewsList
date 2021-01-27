//
//  GalleryPageViewController.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 26.01.21.
//

import UIKit

class GalleryPageViewController: UIViewController {

    var pageViewController : UIPageViewController?
    var galleryData : [GalleryCoreData]?
    var videoData : [VideoCoreData]?
    var pageCount = 0
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageData()
        showDismisButton()
        self.view.backgroundColor = .appColor
    }
    //add page view to view controller
    func pageData() {
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController!.dataSource = self
        pageViewController!.delegate = self
        pageViewController!.view.backgroundColor = UIColor.white
        let startingViewController: ShowImageAndVideoVC = viewControllerAtIndex(index: index)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height);
        pageViewController!.view.backgroundColor = .appColor
        addChild(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParent: self)
        
    }
    //create dismiss button
    func showDismisButton() {
        let parentSize = self.view.frame
        let constreit: CGFloat = 30
        let buttonHeight: CGFloat = 50
        let photoViewFrame = CGRect(x: parentSize.minX + constreit ,
                                    y: parentSize.minY + constreit ,
                                    width: buttonHeight,
                                    height: buttonHeight)
        let photoButton = CustomView(frame: photoViewFrame, imageName: .xmark)
        photoButton.tapGestureRecognizersOfView(selectedView: #selector(photoViewAction), target: self)
        self.view.addSubview(photoButton)
    }
    
    @objc func photoViewAction() {
        
        UINavigationBar.appearance().prefersLargeTitles = true
        self.dismiss(animated: true)
        
    }

}
// MARK: page view
extension GalleryPageViewController : UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ShowImageAndVideoVC).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ShowImageAndVideoVC).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if (index == self.pageCount) {
            return nil
        }
        return self.viewControllerAtIndex(index: index)
    }
    
    func viewControllerAtIndex(index: Int) -> ShowImageAndVideoVC? {
        
        if self.pageCount == 0 || index >= self.pageCount {
            return nil
        }
        let pageContentViewController = ShowImageAndVideoVC()
        pageContentViewController.pageIndex = index
 
        pageContentViewController.imageURL = self.galleryData?[index].contentUrl ?? ""
        pageContentViewController.youtubeId = self.videoData?[index].youtubeId ?? ""
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return self.pageCount
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
