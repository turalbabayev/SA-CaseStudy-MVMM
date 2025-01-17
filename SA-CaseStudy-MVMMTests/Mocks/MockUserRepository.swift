import RxSwift
@testable import SA_CaseStudy_MVMM

class MockUserRepository: UserRepositoryProtocol {
    var mockUsers: [User] = []
    var shouldFail = false
    var mockError: Error = NetworkError.noConnection
    
    func fetchUsers() -> Observable<[User]> {
        if shouldFail {
            return Observable.error(mockError)
        }
        return Observable.just(mockUsers)
    }
} 