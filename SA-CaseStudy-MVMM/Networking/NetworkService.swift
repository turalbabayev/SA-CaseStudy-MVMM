//
//  NetworkService.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import Foundation
import RxSwift

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func request<T: Decodable>(urlString: String) -> Observable<T> {
        return Observable.create { observer in
            guard let url = URL(string: urlString) else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(NetworkError.noConnection)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.onError(NetworkError.serverError(0))
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    observer.onError(NetworkError.serverError(httpResponse.statusCode))
                    return
                }
                
                guard let data = data else {
                    observer.onError(NetworkError.noData)
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(decodedData)
                    observer.onCompleted()
                } catch {
                    observer.onError(NetworkError.decodingError)
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
