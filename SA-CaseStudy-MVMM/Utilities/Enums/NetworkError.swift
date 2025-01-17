

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case noConnection
    
    var localizedDescription: String {
        switch self {
            case .invalidURL: return "Geçersiz URL"
            case .noData: return "Veri bulunamadı"
            // ...
        }
    }
} 
