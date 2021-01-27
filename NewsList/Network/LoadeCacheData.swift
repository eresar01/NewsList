//
//  LoadeCacheData.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 22.01.21.
//

import Foundation
import CoreData

class LoadeCacheData  {
    
    private init() {}
    
    
   static func loadeMetaCoreData() -> [MetaCoreData] {
        var postData = [MetaCoreData]()
        let context = PersistenceServce.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MetaCoreData")
        do {
            let posts = try context.fetch(request) as! [MetaCoreData]
            postData = posts
            return postData
        } catch _ as NSError {
            return postData
        }
    }
    
    static func loadeGalleryCoreData(id: Int64) -> [GalleryCoreData] {
        var postData = [GalleryCoreData]()
        let context = PersistenceServce.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GalleryCoreData")
        request.predicate = NSPredicate(format: "id == %i",  id)
        do {
            let posts = try context.fetch(request) as! [GalleryCoreData]
            postData = posts
            return postData
        } catch _ as NSError {
            return postData
        }
    }
    
    static func loadeGalleryCoreData() -> [GalleryCoreData] {
        var postData = [GalleryCoreData]()
        let context = PersistenceServce.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GalleryCoreData")
        
        do {
            let posts = try context.fetch(request) as! [GalleryCoreData]
            postData = posts
            return postData
        } catch _ as NSError {
            return postData
        }
    }
    
    static func loadeVideoCoreData(id: Int64) -> [VideoCoreData] {
        var postData = [VideoCoreData]()
        let context = PersistenceServce.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VideoCoreData")
        request.predicate = NSPredicate(format: "id == %i",  id)
        do {
            let posts = try context.fetch(request) as! [VideoCoreData]
            postData = posts
            return postData
        } catch _ as NSError {
            return postData
        }
    }
    
    static func loadeVideoCoreData() -> [VideoCoreData] {
        var postData = [VideoCoreData]()
        let context = PersistenceServce.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VideoCoreData")
        do {
            let posts = try context.fetch(request) as! [VideoCoreData]
            postData = posts
            return postData
        } catch _ as NSError {
            return postData
        }
    }
    
    static func loadeLookedCoreData(id: Int64) -> LookedCoreData? {
        let context = PersistenceServce.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LookedCoreData")
        request.predicate = NSPredicate(format: "id == %i",  id)
        do {
            let posts = try context.fetch(request) as! [LookedCoreData]
            if posts.count != 0 {
                return posts[0]
            }
            return nil
        } catch _ as NSError {
            return nil
        }
    }
    
    static func loadeLookedCoreData() -> [LookedCoreData] {
        var postData = [LookedCoreData]()
        let context = PersistenceServce.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LookedCoreData")
        do {
            let posts = try context.fetch(request) as! [LookedCoreData]
            postData = posts
            return postData
        } catch _ as NSError {
            return postData
        }
    }
}
