import XCTest
import RxSwift
@testable import SA_CaseStudy_MVMM

class UserListViewModelTests: XCTestCase {
    var viewModel: UserListViewModel!
    var mockRepository: MockUserRepository!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockUserRepository()
        viewModel = UserListViewModel(repository: mockRepository)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testLoadUsersSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch users")
        let mockUsers = [
            User(id: 1, name: "Test User 1", email: "test1@test.com", phone: "123", website: "test1.com"),
            User(id: 2, name: "Test User 2", email: "test2@test.com", phone: "456", website: "test2.com")
        ]
        mockRepository.mockUsers = mockUsers
        
        var receivedUsers: [User]?
        var loadingStates: [Bool] = []
        
        // When
        viewModel.isLoading
            .skip(1)
            .subscribe(onNext: { isLoading in
                loadingStates.append(isLoading)
            })
            .disposed(by: disposeBag)
            
        viewModel.users
            .subscribe(onNext: { users in
                receivedUsers = users
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
            
        viewModel.loadUsers()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedUsers, mockUsers)
        XCTAssertEqual(loadingStates, [true, false])
    }
    
    func testLoadUsersFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch users error")
        mockRepository.shouldFail = true
        mockRepository.mockError = NetworkError.noConnection
        
        var receivedError: String?
        var loadingStates: [Bool] = []
        
        // When
        viewModel.isLoading
            .skip(1)
            .subscribe(onNext: { isLoading in
                loadingStates.append(isLoading)
            })
            .disposed(by: disposeBag)
            
        viewModel.errorMessage
            .subscribe(onNext: { message in
                receivedError = message
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
            
        viewModel.loadUsers()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedError, "Error: İnternet bağlantısı yok")
        XCTAssertEqual(loadingStates, [true, false])
    }
} 