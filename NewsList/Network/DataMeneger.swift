//
//  DataMeneger.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 22.01.21.
//

import Foundation
import RxSwift

class DataMeneger {
    
    static var dataRepository = RemoteDatasource()
    static var saveData = SaveData()
    var reachability = Reachability()
    var delegate: DataMenegerDelegate?
    
    init() {
        DataMeneger.saveData.delegate = self
    }
    //call data from repo
    private func call(print: Bool = false, callback: @escaping (_ result:News) -> Void) {
       let _ = DataMeneger.dataRepository.call(print: print)
            .subscribe(on: MainScheduler.instance)
            .subscribe { (response:News) in
                callback(response)
            } onError: { error in
                    self.delegate?.internetConnectionError(error:error)
            }
    }
    //method for loading data
    private func loadNewsData(_ response: News?) {
        guard let data = response , !data.metadata.isEmpty else { return }
        DataMeneger.saveData.saveAllData(data.metadata)
    }
    
    func loadNewsData() {
        
        if !LoadeCacheData.loadeMetaCoreData().isEmpty {
            delegate?.newsData(isChange: false, newsData: LoadeCacheData.loadeMetaCoreData())
        }
        call(print: false) { self.loadNewsData($0) }
    }
    //control seen/unseen state of news
    func changeIsLooked(id: Int64) {
        if let lookedData: LookedCoreData = LoadeCacheData.loadeLookedCoreData(id : id) {
            lookedData.isLooked = true
            let context = PersistenceServce.context
            do {
                try context.save()
            } catch {
                print("Looked CoreData catch error")
            }
        }
    }
}
//send data to view controller
extension DataMeneger : SaveDataDelegate  {
    func newsData(isSaved: Bool, newsData: [MetaCoreData]) {
        delegate?.newsData(isChange: isSaved, newsData: newsData)
    }
}

protocol DataMenegerDelegate {
    func newsData(isChange : Bool, newsData: [MetaCoreData])
    func internetConnectionError(error : Error)
}
