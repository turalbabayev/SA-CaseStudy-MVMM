//
//  APIManager.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import Foundation
import RxSwift

// MARK: - APIManager
/// Manages all API operations in the application
/// Acts as a facade between network layer and repositories
class APIManager: APIManagerProtocol {
    // MARK: - Properties
    /// Singleton instance for global access
    static let shared = APIManager()
    
    /// Network service to handle HTTP requests
    private let networkService: NetworkService
    
    // MARK: - Initialization
    /// Creates an APIManager instance with a network service
    /// - Parameter networkService: Service to handle network operations, defaults to shared instance
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    // MARK: - API Operations
    /// Fetches users from the remote API
    /// - Returns: Observable array of User objects
    /// - Note: Uses JSONPlaceholder API endpoint /users
    func fetchUsers() -> Observable<[User]> {
        // Delegate the network request to network service
        // This abstraction allows us to:
        // 1. Change the endpoint easily
        // 2. Add request parameters if needed
        // 3. Transform the response if required
        return networkService.request(urlString: Endpoints.getUsers)
    }
}


