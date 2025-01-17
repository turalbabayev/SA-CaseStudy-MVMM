//
//  APIManager.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import Foundation
import RxSwift

class APIManager: APIManagerProtocol {
    static let shared = APIManager()
    private let networkService: NetworkService
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func fetchUsers() -> Observable<[User]> {
        return networkService.request(urlString: Endpoints.getUsers)
    }
}
