//
//  RemoteDatasource.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 22.01.21.
//

import Foundation
import Alamofire
import RxSwift

class RemoteDatasource {
    //custom api for news
    private let API_URL = "https://www.helix.am/temp/json.php"
    
    func call(print: Bool = false) -> Observable<News> {
        return self.makeRecuest(printResponse: print)
    }
    //method for requesting data from api
    private func makeRecuest(printResponse:Bool) -> Observable<News> {
        return Observable.create { (subscriber) -> Disposable in
            let url = self.API_URL
        Alamofire.request(url, method: .get)
        .responseJSON { response in
            switch response.result {
            case .success(_): do {
                do  {
                let response = try JSONDecoder().decode(News.self, from: response.data!)
                    subscriber.onNext(response)
                    if printResponse {
                        print(response)
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                    
                } catch let DecodingError.keyNotFound(key, context) {
                    print("### Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("*** Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                    subscriber.onError(error)
                }
            } case .failure(let error): do {
                subscriber.onError(error)
            }
        }
    }
            return Disposables.create()
        }
    }
}
