import RxSwift
@testable import SA_CaseStudy_MVMM

/// Mock implementation of UserRepositoryProtocol for testing
class MockUserRepository: UserRepositoryProtocol {
    /// Users to return in successful case
    var mockUsers: [User] = []
    /// Whether the mock should simulate failure
    var shouldFail = false
    /// Error to return in failure case
    var mockError: Error = NetworkError.noConnection
    
    func fetchUsers() -> Observable<[User]> {
        if shouldFail {
            return Observable.error(mockError)
        }
        return Observable.just(mockUsers)
    }
} 