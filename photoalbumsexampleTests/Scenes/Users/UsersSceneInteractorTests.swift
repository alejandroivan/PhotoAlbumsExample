@testable import photoalbumsexample
import XCTest

class UsersSceneInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: UsersSceneInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupUsersSceneInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupUsersSceneInteractor() {
        sut = UsersSceneInteractor()
    }

    // MARK: Tests

    func testPresentAllUsersAfterFetchingFromWorker() {
        // Given
        let workerSpy = UsersSceneWorkerMock()
        workerSpy.shouldSuccess = true

        let spy = UsersScenePresentationLogicSpy()

        sut.presenter = spy
        sut.worker = UsersSceneWorkerMock()

        let request = UsersScene.FetchAll.Request()

        // When
        sut.fetchAllUsers(request: request)

        // Then
        XCTAssertTrue(spy.presentUsersListCalled)
    }
}
