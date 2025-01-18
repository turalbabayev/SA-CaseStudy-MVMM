import RxSwift
@testable import SA_CaseStudy_MVMM

// MARK: - MockAPIManager
/// Test double implementing APIManagerProtocol
/// Used for simulating API responses in tests
class MockAPIManager: APIManagerProtocol {
    // MARK: - Test Configuration
    /// Controls whether the mock should return error
    var shouldFail = false
    /// Users to return in successful case
    var mockUsers: [User] = []
    /// Error to return when shouldFail is true
    var mockError: Error = NetworkError.noConnection
    
    // MARK: - APIManagerProtocol Implementation
    func fetchUsers() -> Observable<[User]> {
        if shouldFail {
            return .error(mockError)
        }
        return .just(mockUsers)
    }
} 