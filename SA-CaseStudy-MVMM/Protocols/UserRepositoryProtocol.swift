//
//  UserRepositoryProtocol.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 18.01.2025.
//

import UIKit
import RxSwift

/// Protocol that defines the data operations for User entities
/// Acts as a single source of truth for user data
protocol UserRepositoryProtocol {
    /// Fetches all users from the data source
    /// - Returns: Observable array of User objects
    func fetchUsers() -> Observable<[User]>
} 
