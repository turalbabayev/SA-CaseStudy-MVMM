import XCTest
import RxSwift
@testable import SA_CaseStudy_MVMM

class UserDetailViewModelTests: XCTestCase {
    var viewModel: UserDetailViewModel!
    var testUser: User!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        testUser = User(
            id: 1,
            name: "Test User",
            email: "test@example.com",
            phone: "123-456-7890",
            website: "example.com"
        )
        viewModel = UserDetailViewModel(user: testUser)
    }
    
    override func tearDown() {
        viewModel = nil
        testUser = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testInitialUserDetails() {
        // Given
        let expectation = XCTestExpectation(description: "Initial user details")
        var receivedViewData: UserDetailViewModel.UserDetailViewData?
        
        // When
        viewModel.userDetails
            .subscribe(onNext: { viewData in
                receivedViewData = viewData
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(receivedViewData)
        XCTAssertEqual(receivedViewData?.name, testUser.name)
        XCTAssertEqual(receivedViewData?.email, testUser.email)
        XCTAssertEqual(receivedViewData?.phone, testUser.phone)
        XCTAssertEqual(receivedViewData?.website, "https://" + testUser.website)
    }
    
    func testUserDetailViewDataInitialization() {
        // Given
        let user = User(
            id: 2,
            name: "Another User",
            email: "another@example.com",
            phone: "987-654-3210",
            website: "another.com"
        )
        
        // When
        let viewData = UserDetailViewModel.UserDetailViewData(user: user)
        
        // Then
        XCTAssertEqual(viewData.name, user.name)
        XCTAssertEqual(viewData.email, user.email)
        XCTAssertEqual(viewData.phone, user.phone)
        XCTAssertEqual(viewData.website, "https://" + user.website)
    }
} 