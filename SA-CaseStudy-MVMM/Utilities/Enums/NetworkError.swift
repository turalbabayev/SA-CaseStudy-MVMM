//
//  AppCoordinator.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 18.01.2025.
//

import Foundation

/// Represents possible network operation errors
/// Provides localized error messages for user feedback
enum NetworkError: LocalizedError, Equatable {
    /// URL string couldn't be converted to URL object
    case invalidURL
    /// Server responded with empty data
    case noData
    /// JSON parsing failed
    case decodingError
    /// Server returned an error status code
    case serverError(Int)
    /// No internet connection or request failed
    case noConnection
    
    var errorDescription: String? {
        switch self {
            case .invalidURL: return "Geçersiz URL"
            case .noData: return "Veri bulunamadı"
            case .decodingError: return "Veri işleme hatası"
            case .serverError(_): return "Sunucu hatası"
            case .noConnection: return "İnternet bağlantısı yok"
        }
    }
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.noData, .noData),
             (.decodingError, .decodingError),
             (.noConnection, .noConnection):
            return true
        case (.serverError(let code1), .serverError(let code2)):
            return code1 == code2
        default:
            return false
        }
    }
} 
