//
//  NetworkService.swift
//  EllcoBugTrackers
//
//  Created by admin on 24.06.2022.
//

import Foundation
import RxSwift

class NetWorkService: NetWorkServiceInputProtocol{
    
    enum InternetError: String, Error {
        case connectionError = "Ошибка интернет соединения"
        case serverError = "Ошибка соединения с сервером"
    }
    
    
    
    func callApi(page: Int) -> Observable<BugResponse>{
        
        let urlString = "https://lk.ellco.ru:8000/bug_tracker/?page=\(page)"
        
        return Observable<BugResponse>.create { (observer) -> Disposable in
            let url = URL(string: urlString)
            var urlRequest = URLRequest(url: url!)
            urlRequest.setValue("38fa0880d113c79d8e0196481d4f4562576b5348de1ab9619696d3449de5", forHTTPHeaderField: "X-AUTH-TOKEN")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Application")
            let task = URLSession.shared.dataTask(with: urlRequest){data, response, error in
                
                if let HttpResponse = response as? HTTPURLResponse{
                    let statusCode = HttpResponse.statusCode
                    do {
                        let data = data ?? Data()
                        if (200...399).contains(statusCode){
                            let object = try JSONDecoder().decode(BugResponse.self, from: data)
                            observer.onNext(object)
                        }else{
                            
                            
                        }
                    } catch{
                        observer.onError(error)
                    }
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background)).observe(on: MainScheduler())
        
        
        
        
    }
}
