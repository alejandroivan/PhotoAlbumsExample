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

    func testShouldCallFetchAllUsersWhenLoaded() {
        // Given
        let spy = UsersSceneBusinessLogicSpy()
        sut.interactor = spy

        // When
        loadView()

        // Then
        XCTAssertTrue(spy.fetchAllUsersCalled)
    }

    func testShowErrorShouldAddASubview() {
        // Given
        let numberOfViews = sut.view.subviews.count

        // When
        sut.showError()

        // Then
        XCTAssertTrue(sut.view.subviews.count == numberOfViews + 1)
    }

    func testFetchAllUsersShouldStartLoadingAtTheInteractor() {
        // Given
        let spy = UsersSceneBusinessLogicSpy()
        sut.interactor = spy

        // When
        sut.fetchAllUsers()

        // Then
        XCTAssertTrue(sut.isLoading)
        XCTAssertTrue(spy.fetchAllUsersCalled)
    }
}
