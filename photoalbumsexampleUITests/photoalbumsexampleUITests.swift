import XCTest

class photoalbumsexampleUITests: XCTestCase {
    var app: XCUIApplication!
    let userName = "Patricia Lebsack"

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func testFavoritesFilter() {
        let usuariosNavigationBar = app.navigationBars["Usuarios"]
        let userCell = app.tables.cells.staticTexts[userName]
        let backButton = app.navigationBars.buttons.element(boundBy: 0)


        XCTAssertTrue(userCell.exists)
        usuariosNavigationBar.buttons["Solo favoritos"].tap()
        XCTAssertFalse(userCell.exists)
        usuariosNavigationBar.buttons["Mostrar todos"].tap()

        userCell.tap()

        let favoriteCell = app.tables.cells.staticTexts["Marcar como favorito"]
        favoriteCell.tap()

        backButton.tap()

        XCTAssertTrue(userCell.exists)
        usuariosNavigationBar.buttons["Solo favoritos"].tap()
        XCTAssertTrue(userCell.exists)
        usuariosNavigationBar.buttons["Mostrar todos"].tap()

        // Now reset to initial state
        userCell.tap()
        favoriteCell.tap()
        backButton.tap()
    }
}
