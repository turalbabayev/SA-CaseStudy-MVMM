//
//  NetworkService.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import Foundation
import RxSwift

class NetworkService {
    // MARK: - Properties
    static let shared = NetworkService()
    private init() {}
    
    // MARK: - Network Operations
    /// Generic network request method that can decode any Decodable type
    /// - Parameter urlString: The endpoint URL string
    /// - Returns: Observable of generic type T that conforms to Decodable
    func request<T: Decodable>(urlString: String) -> Observable<T> {
        return Observable.create { observer in
            // First validate URL to prevent invalid network calls
            guard let url = URL(string: urlString) else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, networkError in
                // Check for network connectivity issues first
                if networkError != nil {
                    observer.onError(NetworkError.noConnection)
                    return
                }
                
                // Validate HTTP response to ensure proper server communication
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.onError(NetworkError.serverError(0))
                    return
                }
                
                // Check for successful HTTP status codes (200-299)
                guard (200...299).contains(httpResponse.statusCode) else {
                    observer.onError(NetworkError.serverError(httpResponse.statusCode))
                    return
                }
                
                // Ensure we have data to decode
                guard let data = data else {
                    observer.onError(NetworkError.noData)
                    return
                }
                
                // Attempt to decode the response into the expected type
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(decodedData)
                    observer.onCompleted()
                } catch {
                    // If decoding fails, it means the JSON structure doesn't match our model
                    observer.onError(NetworkError.decodingError)
                }
            }
            
            // Start the network request
            task.resume()
            
            // Cleanup when the observable is disposed
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
