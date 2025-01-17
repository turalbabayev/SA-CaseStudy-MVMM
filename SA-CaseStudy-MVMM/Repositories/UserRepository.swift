//
//  UserRepository.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import RxSwift

class UserRepository: UserRepositoryProtocol {
    private let apiManager: APIManager
    
    init(apiManager: APIManager = .shared) {
        self.apiManager = apiManager
    }
    
    func fetchUsers() -> Observable<[User]> {
        return apiManager.fetchUsers()
    }
}
