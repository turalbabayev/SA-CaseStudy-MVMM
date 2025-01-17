//
//  APIManager.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import Foundation
import RxSwift

class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func fetchUsers() -> Observable<[User]>{
        return NetworkService.shared.request(urlString: Endpoints.getUsers)
    }
}
