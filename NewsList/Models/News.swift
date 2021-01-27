//
//  News.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 22.01.21.
//

import Foundation

struct News : Codable {
    var success : Bool
    var errors : [Int]
    var internal_errors : [Int]
    var metadata : [MetaData]
}

struct MetaData : Codable {
    
    var category : String
    var title : String
    var body : String
    var shareUrl : String
    var coverPhotoUrl : String
    var date : Int
    var gallery : [Gallery]?
    var video : [Video]?
}

struct Gallery : Codable {
    var title : String
    var thumbnailUrl : String
    var contentUrl : String
}

struct Video : Codable {
    var title : String
    var thumbnailUrl : String
    var youtubeId : String
}

//this struct is for showing brief data on the list
struct ShortNews {
    var metaData : MetaCoreData
    
    var title : String {
        return metaData.title ?? ""
    }
    var category : String {
        return metaData.category ?? ""
    }
    var coverPhotoUrl : String {
        return metaData.coverPhotoUrl ?? ""
    }
    var date : Int64 {
        return metaData.date
    }
    var isLooked : Bool {
         if let data = LoadeCacheData.loadeLookedCoreData(id: date) {
            return data.isLooked
        }
        return false
    }
}
