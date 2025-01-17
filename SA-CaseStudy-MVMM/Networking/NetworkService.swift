//
//  NetworkService.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import Foundation
import RxSwift

class NetworkService{
    static let shared = NetworkService()
    
    private init(){}
    
    func request<T:Decodable>(urlString: String) -> Observable<T>{
        return Observable.create { observer in
            guard let url = URL(string: urlString) else {
                observer.onError(NSError(domain: "InvalidURL", code: -1))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error{
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "NoData", code: -1))
                    return
                }
                
                do{
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(decodedObject)
                    observer.onCompleted()
                }catch{
                    observer.onError(error)
                }
            }
            
            task.resume()
            return Disposables.create { task.cancel() }

        }
    }
}
