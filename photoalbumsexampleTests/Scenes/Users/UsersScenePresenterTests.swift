@testable import photoalbumsexample
import XCTest

class UsersScenePresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: UsersScenePresenter!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupUsersScenePresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupUsersScenePresenter() {
        sut = UsersScenePresenter()
    }

    // MARK: Tests

    func testShowUsersOnScreenAfterPresenting() {
        // Given
        let spy = UsersSceneDisplayLogicSpy()
        sut.viewController = spy
        let response = UsersScene.FetchAll.Response()

        // When
        sut.presentUsersList(response: response)

        // Then
        XCTAssertTrue(spy.showUsersCalled)
        XCTAssertFalse(spy.showErrorCalled)
    }

    func testShowErrorViewOnScreenAfterPresenting() {
        // Given
        let spy = UsersSceneDisplayLogicSpy()
        sut.viewController = spy

        // When
        sut.presentErrorMessage()

        // Then
        XCTAssertFalse(spy.showUsersCalled)
        XCTAssertTrue(spy.showErrorCalled)
    }
}
