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
        var isLoadingValues: [Bool] = []
        
        // When
        viewModel.users
            .subscribe(onNext: { users in
                receivedUsers = users
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .subscribe(onNext: { isLoading in
                isLoadingValues.append(isLoading)
            })
            .disposed(by: disposeBag)
        
        viewModel.loadUsers()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedUsers, mockUsers)
        XCTAssertEqual(isLoadingValues, [true, false])
    }
    
    func testLoadUsersError() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch users error")
        let mockError = NetworkError.noConnection
        mockRepository.shouldFail = true
        mockRepository.mockError = mockError
        
        var receivedError: String?
        var isLoadingValues: [Bool] = []
        
        // When
        viewModel.errorMessage
            .subscribe(onNext: { error in
                receivedError = error
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .subscribe(onNext: { isLoading in
                isLoadingValues.append(isLoading)
            })
            .disposed(by: disposeBag)
        
        viewModel.loadUsers()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(receivedError?.contains("Error:") ?? false)
        XCTAssertEqual(isLoadingValues, [true, false])
    }
} 