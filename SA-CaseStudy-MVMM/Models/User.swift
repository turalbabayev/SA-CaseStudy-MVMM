//
//  User.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import Foundation

// MARK: - User Model
/// Represents a user entity in the application
/// Used for displaying user information and API communication
struct User: Decodable, Equatable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
}
