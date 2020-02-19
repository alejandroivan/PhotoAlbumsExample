@testable import photoalbumsexample
import XCTest

class UsersSceneViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: UsersSceneViewController!
    var window: UIWindow!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupUsersSceneViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    
    func setupUsersSceneViewController() {
        sut = UsersSceneViewController()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests

//    func testShouldDoSomethingWhenViewIsLoaded() {
//        // Given
//        let spy = UsersSceneBusinessLogicSpy()
//        sut.interactor = spy
//
//        // When
//        loadView()
//
//        // Then
//        XCTAssertTrue(spy.fetchAllUsersCalled)
//    }
}
