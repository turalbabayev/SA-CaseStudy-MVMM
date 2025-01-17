//
//  UserRepository.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import RxSwift

class UserRepository {
    func fetchUsers() -> Observable<[User]>{
        return APIManager.shared.fetchUsers()
    }
}
