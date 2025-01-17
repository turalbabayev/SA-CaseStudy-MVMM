//
//  User.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import Foundation

struct User: Decodable{
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
}
