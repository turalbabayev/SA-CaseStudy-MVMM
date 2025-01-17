import RxSwift
@testable import SA_CaseStudy_MVMM

class MockAPIManager: APIManagerProtocol {
    var shouldFail = false
    var mockUsers: [User] = []
    var mockError: Error = NetworkError.noConnection
    
    func fetchUsers() -> Observable<[User]> {
        if shouldFail {
            return .error(mockError)
        }
        return .just(mockUsers)
    }
} 