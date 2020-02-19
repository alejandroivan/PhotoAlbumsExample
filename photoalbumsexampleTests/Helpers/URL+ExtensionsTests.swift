import XCTest
@testable import photoalbumsexample

class URL_ExtensionsTests: XCTestCase {
    var sut: URL!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Constants.API.base
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testURLExtensionCorrectlyAddedExtraParameters() {
        // Given
        let parameters: [String: String] = [
            "key1": "value1",
            "key2": "value2"
        ]

        // When
        let finalURL = sut.urlByAddingParameters(parameters)
        let components = URLComponents(url: finalURL, resolvingAgainstBaseURL: true)!
        let queryItems = components.queryItems?.map { [$0.name: $0.value] }

        // Then
        XCTAssertNotNil(queryItems)

        queryItems?.forEach { item in
            for (key, value) in item {
                XCTAssertTrue(parameters.keys.contains(key))
                XCTAssertEqual(parameters[key], value)
            }
        }
    }
}
