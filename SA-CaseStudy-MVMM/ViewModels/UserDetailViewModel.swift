//
//  UserDetailViewModel.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import Foundation
import RxSwift

class UserDetailViewModel {
    private let user: User
    let userDetails: BehaviorSubject<UserDetailViewData>

    struct UserDetailViewData {
        let name: String
        let email: String
        let phone: String
        let website: String
        
        init(user: User) {
            self.name = user.name
            self.email = user.email
            self.phone = user.phone
            self.website = "https://" + user.website
        }
    }
    
    init(user: User) {
        self.user = user
        let viewData = UserDetailViewData(user: user)
        self.userDetails = BehaviorSubject<UserDetailViewData>(value: viewData)
    }
    
}
