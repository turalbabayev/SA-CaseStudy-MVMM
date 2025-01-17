//
//  UserRepositoryProtocol.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 18.01.2025.
//

import UIKit
import RxSwift

protocol UserRepositoryProtocol {
    func fetchUsers() -> Observable<[User]>
} 
