import XCTest
@testable import SA_CaseStudy_MVMM

/// Tests for User model decoding functionality
class UserTests: XCTestCase {
    /// Tests successful decoding of valid JSON to User object
    func testUserDecoding() {
        // Given
        let json = """
        {
            "id": 1,
            "name": "Test User",
            "email": "test@example.com",
            "phone": "123-456-7890",
            "website": "example.com"
        }
        """.data(using: .utf8)!
        
        // When
        let user = try? JSONDecoder().decode(User.self, from: json)
        
        // Then
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.id, 1)
        XCTAssertEqual(user?.name, "Test User")
        XCTAssertEqual(user?.email, "test@example.com")
        XCTAssertEqual(user?.phone, "123-456-7890")
        XCTAssertEqual(user?.website, "example.com")
    }
    
    /// Tests that invalid JSON fails to decode into User object
    func testInvalidUserDecoding() {
        // Given
        let invalidJson = """
        {
            "id": "invalid",
            "name": 123,
            "email": true
        }
        """.data(using: .utf8)!
        
        // When
        let user = try? JSONDecoder().decode(User.self, from: invalidJson)
        
        // Then
        XCTAssertNil(user)
    }
} 