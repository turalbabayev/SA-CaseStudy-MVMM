//
//  APIManagerProtocol.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import RxSwift

protocol APIManagerProtocol {
    func fetchUsers() -> Observable<[User]>
} 
