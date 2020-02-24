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

        let request = UsersScene.FetchAll.Request(favoritesOnly: false)

        // When
        sut.fetchAllUsers(request: request)

        // Then
        XCTAssertTrue(spy.presentUsersListCalled)
        XCTAssertFalse(spy.presentErrorMessageCalled)
    }

    func testFilterFavoritesAfterGettingTheWholeList() {
        // Given
        let workerSpy = UsersSceneWorkerMock()
        workerSpy.shouldSuccess = true

        let spy = UsersScenePresentationLogicSpy()

        sut.presenter = spy
        sut.worker = UsersSceneWorkerMock()

        let request = UsersScene.FetchAll.Request(favoritesOnly: false)
        sut.fetchAllUsers(request: request)

        // When
        let secondRequest = UsersScene.FetchAll.Request(favoritesOnly: true)
        sut.fetchAllUsers(request: secondRequest)

        // Then
        XCTAssertTrue(spy.presentUsersListCalled)
        XCTAssertFalse(spy.presentErrorMessageCalled)
    }

    func testPresentErrorViewAfterFailingFetchingFromWorker() {
        // Given
        let workerSpy = UsersSceneWorkerMock()
        workerSpy.shouldSuccess = false

        let spy = UsersScenePresentationLogicSpy()

        sut.presenter = spy
        sut.worker = workerSpy

        let request = UsersScene.FetchAll.Request(favoritesOnly: false)

        // When
        sut.fetchAllUsers(request: request)

        // Then
        XCTAssertFalse(spy.presentUsersListCalled)
        XCTAssertTrue(spy.presentErrorMessageCalled)
    }
}
