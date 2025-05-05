//
//  news_aggerator_appUITests.swift
//  news_aggerator_appUITests
//
//  Created by user270598 on 4/16/25.
//

import XCTest

final class NewsAggregatorAppUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launchEnvironment = [
            "UITEST_DISABLE_ANIMATIONS": "1",
            "SIMULATOR_VERBOSE_STARTUP": "1"
        ]
        
        app.launchArguments = [
            "--uitesting",
            "-StartCleanInstall", "YES"
        ]
        
        app.launch()
    }
    
    override func tearDownWithError() throws {}
    
    func testWelcomeViewNavigation() {
        XCTAssertTrue(app.images["AppWelcomeImage"].exists)
        XCTAssertTrue(app.staticTexts["Welcome to News Aggregator App"].exists)
        XCTAssertTrue(app.staticTexts["Your one-stop hub for the latest headlines!"].exists)
        XCTAssertTrue(app.buttons["Continue"].exists)
        
        app.buttons["Continue"].tap()
        
        XCTAssertTrue(app.staticTexts["Login Here"].exists)
    }
    
    func testLoginViewElements() {
        if app.buttons["Continue"].exists {
            app.buttons["Continue"].tap()
        }
        
        let emailTextField = app.textFields["Enter your username"]
        
        XCTAssertTrue(app.staticTexts["Login Here"].exists)
        XCTAssertTrue(emailTextField.exists)
        XCTAssertTrue(app.secureTextFields["Enter your Password"].exists)
        XCTAssertTrue(app.buttons["Login"].exists)
        XCTAssertTrue(app.buttons["Don't have an account? Register"].exists)
        XCTAssertTrue(app.buttons["Cancel"].exists)
    }
    
    func testNavigateToRegisterView() {
        if app.buttons["Continue"].exists {
            app.buttons["Continue"].tap()
        }

        app.buttons["Don't have an account? Register"].tap()
    }
    
    func testCancelLogin() {
        if app.buttons["Continue"].exists {
            app.buttons["Continue"].tap()
        }
        
        app.buttons["Cancel"].tap()
        XCTAssertTrue(app.staticTexts["Welcome to News Aggregator App"].exists)
    }
    
    func testRegisterViewElements() {
        if app.buttons["Continue"].exists {
            app.buttons["Continue"].tap()
        }
        app.buttons["Don't have an account? Register"].tap()
        
        XCTAssertTrue(app.staticTexts["Register Here"].exists)
        XCTAssertTrue(app.textFields["Username"].exists)
        XCTAssertTrue(app.textFields["Email"].exists)
        XCTAssertTrue(app.secureTextFields["Password"].exists)
        XCTAssertTrue(app.secureTextFields["Confirm Password"].exists)
        XCTAssertTrue(app.buttons["Register"].exists)
        XCTAssertTrue(app.buttons["Cancel"].exists)
    }
    
    func testCancelRegister() {
        if app.buttons["Continue"].exists {
            app.buttons["Continue"].tap()
        }
        app.buttons["Don't have an account? Register"].tap()
        
        app.buttons["Cancel"].tap()

        XCTAssertTrue(app.staticTexts["Login Here"].waitForExistence(timeout: 5))
    }
    
    func testNavigationToTabs() {
            // Given
            let continueButton = app.buttons["Continue"]
            XCTAssertTrue(continueButton.exists, "Continue button should be visible")

            // When
            continueButton.tap()

            let emailTextField = app.textFields["Enter your username"]
            XCTAssertTrue(emailTextField.waitForExistence(timeout: 5), "Email text field should be visible")
            emailTextField.tap()
            emailTextField.typeText("test@example.com")

            let passwordSecureField = app.secureTextFields["Enter your Password"]
            XCTAssertTrue(passwordSecureField.waitForExistence(timeout: 5), "Password secure field should be visible")
            passwordSecureField.tap()
            passwordSecureField.typeText("password123")

            let loginButton = app.buttons["Login"]
            XCTAssertTrue(loginButton.waitForExistence(timeout: 5), "Login button should be visible")
            loginButton.tap()

            // Then
            let tabBar = app.tabBars.firstMatch
            XCTAssertTrue(tabBar.waitForExistence(timeout: 5), "Tab bar should be present after login")

            let homeTab = tabBar.buttons["Home"]
            let searchTab = tabBar.buttons["Search"]
            let bookmarksTab = tabBar.buttons["Bookmarks"]

            XCTAssertTrue(homeTab.exists, "Home tab should be present")
            XCTAssertTrue(searchTab.exists, "Search tab should be present")
            XCTAssertTrue(bookmarksTab.exists, "Bookmarks tab should be present")
        }
    
        func testNewsFeedViewDisplaysArticles() {
            // Given
            let continueButton = app.buttons["Continue"]
            continueButton.tap()

            let emailTextField = app.textFields["Enter your username"]
            XCTAssertTrue(emailTextField.waitForExistence(timeout: 5), "Email text field should be visible")
            emailTextField.tap()
            emailTextField.typeText("test@example.com")

            let passwordSecureField = app.secureTextFields["Enter your Password"]
            XCTAssertTrue(passwordSecureField.waitForExistence(timeout: 5), "Password secure field should be visible")
            passwordSecureField.tap()
            passwordSecureField.typeText("password123")

            let loginButton = app.buttons["Login"]
            XCTAssertTrue(loginButton.waitForExistence(timeout: 5), "Login button should be visible")
            loginButton.tap()

            let homeTab = app.tabBars.buttons["Home"]
            XCTAssertTrue(homeTab.waitForExistence(timeout: 10), "Home tab should be present after login")
            homeTab.tap()

            // When
            let newsFeedTitle = app.navigationBars["Top Headlines"]
            XCTAssertTrue(newsFeedTitle.waitForExistence(timeout: 5), "NewsFeedView should be displayed")

            // Then
            let firstArticle = app.cells.firstMatch
            XCTAssertTrue(firstArticle.waitForExistence(timeout: 5), "There should be articles in NewsFeedView")
        }
    
    func testSearchBarInteraction() {
            // Given
            let continueButton = app.buttons["Continue"]
            continueButton.tap()

            let emailTextField = app.textFields["Enter your username"]
            XCTAssertTrue(emailTextField.waitForExistence(timeout: 5), "Email text field should be visible")
            emailTextField.tap()
            emailTextField.typeText("test@example.com")

            let passwordSecureField = app.secureTextFields["Enter your Password"]
            XCTAssertTrue(passwordSecureField.waitForExistence(timeout: 5), "Password secure field should be visible")
            passwordSecureField.tap()
            passwordSecureField.typeText("password123")

            let loginButton = app.buttons["Login"]
            XCTAssertTrue(loginButton.waitForExistence(timeout: 5), "Login button should be visible")
            loginButton.tap()

            let searchTab = app.tabBars.buttons["Search"]
            XCTAssertTrue(app.tabBars.firstMatch.waitForExistence(timeout: 5), "Tab bar should be present after login")
            searchTab.tap()

            let searchViewTitle = app.navigationBars["Search here"]
            XCTAssertTrue(searchViewTitle.waitForExistence(timeout: 5), "SearchView should be displayed")

            // When
            let searchField = app.textFields.firstMatch
            XCTAssertTrue(searchField.waitForExistence(timeout: 5), "Search field should be present")

            searchField.tap()
            searchField.typeText("Technology\n")

            // Then
            let firstResult = app.cells.firstMatch
            XCTAssertTrue(firstResult.waitForExistence(timeout: 5), "Search results should appear")
        }

        func testBookmarksViewDisplaysBookmarkedArticles() {
            // Given
            let continueButton = app.buttons["Continue"]
            continueButton.tap()

            let emailTextField = app.textFields["Enter your username"]
            XCTAssertTrue(emailTextField.waitForExistence(timeout: 5), "Email text field should be visible")
            emailTextField.tap()
            emailTextField.typeText("test@example.com")

            let passwordSecureField = app.secureTextFields["Enter your Password"]
            XCTAssertTrue(passwordSecureField.waitForExistence(timeout: 5), "Password secure field should be visible")
            passwordSecureField.tap()
            passwordSecureField.typeText("password123")

            let loginButton = app.buttons["Login"]
            XCTAssertTrue(loginButton.waitForExistence(timeout: 5), "Login button should be visible")
            loginButton.tap()

            let bookmarksTab = app.tabBars.buttons["Bookmarks"]
            XCTAssertTrue(app.tabBars.firstMatch.waitForExistence(timeout: 5), "Tab bar should be present after login")
            bookmarksTab.tap()

            let bookmarksTitle = app.navigationBars["Bookmarks"]
            XCTAssertTrue(bookmarksTitle.waitForExistence(timeout: 5), "BookmarksView should be displayed")

            // When
            let firstBookmark = app.cells.firstMatch

            // Then
            XCTAssertTrue(firstBookmark.waitForExistence(timeout: 5), "There should be bookmarked articles in BookmarksView")
        }

        func testFullArticleViewDisplaysCorrectly() {
            // Given
            let continueButton = app.buttons["Continue"]
            if continueButton.waitForExistence(timeout: 5) {
                continueButton.tap()
            }

            let emailTextField = app.textFields["Enter your username"]
            XCTAssertTrue(emailTextField.waitForExistence(timeout: 5), "Email text field should be visible")
            emailTextField.tap()
            emailTextField.typeText("test@example.com")

            let passwordSecureField = app.secureTextFields["Enter your Password"]
            XCTAssertTrue(passwordSecureField.waitForExistence(timeout: 5), "Password secure field should be visible")
            passwordSecureField.tap()
            passwordSecureField.typeText("password123")

            let loginButton = app.buttons["Login"]
            XCTAssertTrue(loginButton.waitForExistence(timeout: 5), "Login button should be visible")
            loginButton.tap()

            let homeTab = app.tabBars.buttons["Home"]
            XCTAssertTrue(app.tabBars.firstMatch.waitForExistence(timeout: 10), "Tab bar missing after login")
            homeTab.tap()

            let articlesList = app.otherElements["NewsFeedList"]
            XCTAssertTrue(articlesList.waitForExistence(timeout: 15), "News feed failed to load")

            let firstArticle = app.cells.element(boundBy: 0)
            XCTAssertTrue(firstArticle.waitForExistence(timeout: 10), "No articles found")

            // When
            let articleID = firstArticle.identifier
            print("Testing article with ID: \(articleID)")

            firstArticle.tap()

            // Then
            let backButton = app.navigationBars.buttons["Top Headlines"]
            XCTAssertTrue(backButton.waitForExistence(timeout: 10), "Navigation failed - back button missing")

            let articleTitle = app.staticTexts.matching(identifier: "ArticleTitle_").firstMatch
            XCTAssertTrue(articleTitle.waitForExistence(timeout: 5), "Article title missing")

            let anyDetailElement = app.scrollViews.firstMatch
            XCTAssertTrue(anyDetailElement.waitForExistence(timeout: 5), "No detail content loaded")
        }
    
}
