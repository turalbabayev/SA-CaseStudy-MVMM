//
//  UserRepository.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import RxSwift

// MARK: - UserRepository
/// Repository that manages user data operations and acts as a single source of truth
/// Uses APIManager for remote data fetching, could be extended for local caching
class UserRepository: UserRepositoryProtocol {
    // MARK: - Properties
    private let apiManager: APIManager
    
    init(apiManager: APIManager = .shared) {
        self.apiManager = apiManager
    }
    
    // MARK: - UserRepositoryProtocol Implementation
    /// Fetches users from the remote API
    /// - Returns: Observable array of User objects
    func fetchUsers() -> Observable<[User]> {
        // TODO: Consider adding local caching and offline support
        return apiManager.fetchUsers()
    }
}
