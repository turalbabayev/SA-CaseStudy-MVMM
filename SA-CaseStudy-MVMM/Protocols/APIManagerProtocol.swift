//
//  APIManagerProtocol.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import RxSwift

/// Protocol that defines the API operations for the application
/// Used to abstract network layer implementation details from the repository
protocol APIManagerProtocol {
    /// Fetches users from the remote API
    /// - Returns: Observable array of User objects
    func fetchUsers() -> Observable<[User]>
} 
