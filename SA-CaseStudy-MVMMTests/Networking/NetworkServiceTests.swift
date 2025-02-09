import XCTest
import RxSwift
@testable import SA_CaseStudy_MVMM

// MARK: - NetworkServiceTests
/// Tests for NetworkService functionality
class NetworkServiceTests: XCTestCase {
    // MARK: - Properties
    var networkService: NetworkService!
    var disposeBag: DisposeBag!
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        networkService = NetworkService.shared
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        networkService = nil
        disposeBag = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    /// Tests successful API request and response handling
    func testSuccessfulRequest() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch users")
        let endpoint = Endpoints.getUsers
        var receivedUsers: [User]?
        var receivedError: Error?
        
        // When
        networkService.request(urlString: endpoint)
            .subscribe(
                onNext: { (users: [User]) in
                    receivedUsers = users
                    expectation.fulfill()
                },
                onError: { error in
                    receivedError = error
                    expectation.fulfill()
                }
            )
            .disposed(by: disposeBag)
        
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(receivedError)
        XCTAssertNotNil(receivedUsers)
        XCTAssertFalse(receivedUsers?.isEmpty ?? true)
    }
    
    /// Tests handling of invalid URL strings
    func testInvalidURLRequest() {
        // Given
        let expectation = XCTestExpectation(description: "Invalid URL")
        let invalidEndpoint = "ht tp:// invalid url" // Açıkça geçersiz bir URL
        var receivedError: Error?
        
        // When
        networkService.request(urlString: invalidEndpoint)
            .subscribe(
                onNext: { (users: [User]) in
                    XCTFail("Should not receive users for invalid URL")
                },
                onError: { error in
                    receivedError = error
                    expectation.fulfill()
                }
            )
            .disposed(by: disposeBag)
        
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(receivedError, "Error should not be nil")
        
        if let error = receivedError as? NetworkError {
            XCTAssertEqual(error, NetworkError.invalidURL)
        } else {
            XCTFail("Error should be NetworkError")
        }
    }
    
    /// Tests handling of JSON decoding errors
    func testDecodingError() {
        // Given
        let expectation = XCTestExpectation(description: "Decoding error")
        let invalidEndpoint = "https://jsonplaceholder.typicode.com/posts" // Farklı bir JSON yapısı
        var receivedError: Error?
        
        // When
        networkService.request(urlString: invalidEndpoint)
            .subscribe(
                onNext: { (users: [User]) in
                    XCTFail("Should not decode invalid JSON to User objects")
                },
                onError: { error in
                    receivedError = error
                    expectation.fulfill()
                }
            )
            .disposed(by: disposeBag)
        
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(receivedError)
        XCTAssertTrue(receivedError is NetworkError)
        XCTAssertEqual(receivedError as? NetworkError, .decodingError)
    }
} 