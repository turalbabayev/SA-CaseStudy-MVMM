//
//  UserDetailViewModel.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import Foundation
import RxSwift

/// ViewModel that manages the user detail screen's business logic and data
class UserDetailViewModel {
    private let user: User
    
    /// Published stream of user details formatted for display
    let userDetails: BehaviorSubject<UserDetailViewData>
    
    /// View data structure that formats user data for display
    struct UserDetailViewData {
        let name: String
        let email: String
        let phone: String
        let website: String
        
        /// Creates view data from a user model
        /// - Parameter user: Source user model
        init(user: User) {
            self.name = user.name
            self.email = user.email
            self.phone = user.phone
            self.website = "https://" + user.website
        }
    }
    
    /// Initializes the view model with a user
    /// - Parameter user: User to display details for
    init(user: User) {
        self.user = user
        let viewData = UserDetailViewData(user: user)
        self.userDetails = BehaviorSubject<UserDetailViewData>(value: viewData)
    }
}
