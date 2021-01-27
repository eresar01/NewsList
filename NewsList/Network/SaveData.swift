//
//  SaveData.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 22.01.21.
//

import Foundation
import CoreData
import RxSwift

class SaveData {
    
    let context = PersistenceServce.context
    var delegate : SaveDataDelegate?
    
func saveAllData(_ metaData : [MetaData]){
    let data = LoadeCacheData.loadeMetaCoreData()
    let galleryData = LoadeCacheData.loadeGalleryCoreData()
    let videoData = LoadeCacheData.loadeVideoCoreData()
    let ed = NSEntityDescription.entity(forEntityName: "MetaCoreData", in: context)
    
        //method for getting metadata and integrating core data
        func chengeDate(_ newData : MetaData) {
            let cacheData  =  MetaCoreData(entity: ed!, insertInto: context)
            cacheData.category = newData.category
            cacheData.title = newData.title
            cacheData.body = newData.body
            cacheData.coverPhotoUrl = newData.coverPhotoUrl
            cacheData.date = Int64(newData.date)

            //get images data for gallery
            if let galleryItem = newData.gallery , galleryItem.count > 0  {
                for value in galleryItem {
                    let cacheGallery = GalleryCoreData(entity: NSEntityDescription.entity(forEntityName: "GalleryCoreData", in: context)!, insertInto: context)
                    cacheGallery.metaData = cacheData
                    cacheGallery.title = value.title
                    cacheGallery.thumbnailUrl = value.thumbnailUrl
                    cacheGallery.contentUrl = value.contentUrl
                }
            }
            // get videos data for gallery
            if let videoItem = newData.video , videoItem.count > 0  {
                for value in videoItem {
                    let cacheVideo = VideoCoreData(entity: NSEntityDescription.entity(forEntityName: "VideoCoreData", in: context)!, insertInto: context)
                    
                    cacheVideo.metaData = cacheData
                    cacheVideo.title = value.title
                    cacheVideo.thumbnailUrl = value.thumbnailUrl
                    cacheVideo.youtubeId = value.youtubeId

                }
            }
            //get data when news is seen
            if LoadeCacheData.loadeLookedCoreData(id: Int64(newData.date)) == nil {
                let cacheLooked = NSEntityDescription.insertNewObject(forEntityName: "LookedCoreData", into: context)
                cacheLooked.setValue(Int64(newData.date), forKey: "id")
                cacheLooked.setValue(false, forKey: "isLooked")
            }
            do {
                try context.save()
            } catch {
                print("MetaData CoreData catch error")
            }
        }
    //method for checking news update
        func isChenge(_ newData : [MetaData],_ olddata : [MetaCoreData]) -> Bool {
            if olddata.isEmpty {
                return true
            }
            if  newData.first?.title != olddata.first?.title || newData.last?.title != olddata.last?.title {
                return true
            }
            return false
        }
//change data if news is updated
    if isChenge(metaData, data) {
        if metaData.count == data.count {
            for i in 0..<data.count {
                context.delete(data[i])
                chengeDate(metaData[i])
            }
        } else {
            for i in 0..<data.count {
                context.delete(data[i])
            }
            for item in metaData {
                chengeDate(item)
            }
        }
        for i in 0..<galleryData.count {
            context.delete(galleryData[i])
        }
        for i in 0..<videoData.count {
            context.delete(videoData[i])
        }
    }
    //send data to data manager
    let newData = LoadeCacheData.loadeMetaCoreData()
    delegate?.newsData(isSaved: isChenge(metaData, data), newsData: newData)
    }
}

protocol SaveDataDelegate {
    func newsData(isSaved : Bool, newsData: [MetaCoreData])
}
