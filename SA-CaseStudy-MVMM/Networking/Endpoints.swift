//
//  Endpoints.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import Foundation

// MARK: - API Endpoints
/// Centralized endpoint definitions
/// Makes it easier to:
/// 1. Change base URL for different environments (dev, staging, prod)
/// 2. Maintain all endpoints in one place
/// 3. Add new endpoints with proper organization
struct Endpoints {
    /// Base URL for the API
    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    /// Endpoint to fetch all users
    static let getUsers = "\(baseURL)/users"
}
