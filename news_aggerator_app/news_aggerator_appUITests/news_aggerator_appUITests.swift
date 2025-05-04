//
//  news_aggerator_appUITests.swift
//  news_aggerator_appUITests
//
//  Created by user270598 on 4/16/25.
//

import XCTest

final class news_aggerator_appUITests:XCTestCase {
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

    func testWelcomeViewDismissesToContentView() {
        // Given
        let title = app.staticTexts["Welcome to News Aggregator App"]
        let subtitle = app.staticTexts["Your one-stop hub for the latest headlines!"]
        let continueButton = app.buttons["Continue"]
        
        XCTAssertTrue(title.exists, "Title should be displayed")
        XCTAssertTrue(subtitle.exists, "Subtitle should be displayed")
        XCTAssertTrue(continueButton.exists, "Continue button should exist")
        
        //When
        continueButton.tap()
        
        // Then
        XCTAssertFalse(title.exists, "WelcomeView should be dismissed")
        XCTAssertFalse(subtitle.exists, "WelcomeView should be dismissed")
        XCTAssertFalse(continueButton.exists, "WelcomeView should be dismissed")
        
        XCTAssertTrue(app.tabBars.count > 0, "ContentView should be displayed")
    }

    func testNavigationToTabs() {
        // Given
        let continueButton = app.buttons["Continue"]
        XCTAssertTrue(continueButton.exists, "Continue button should be visible")

        // When
        continueButton.tap()

        // Then
        let tabBar = app.tabBars
        XCTAssertTrue(tabBar.count > 0, "Tab bar should be present")

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

        let homeTab = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTab.waitForExistence(timeout: 5), "Home tab should be present")
        homeTab.tap()

        // When
        let newsFeedTitle = app.navigationBars["Top Headlines"]
        XCTAssertTrue(newsFeedTitle.waitForExistence(timeout: 5), "NewsFeedView should be displayed")

        // Then
        let firstArticle = app.cells.firstMatch
        XCTAssertTrue(firstArticle.exists, "There should be articles in NewsFeedView")
    }

    func testSearchBarInteraction() {
        // Given
        let continueButton = app.buttons["Continue"]
        continueButton.tap()
        
        let searchTab = app.tabBars.buttons["Search"]
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
        
        let bookmarksTab = app.tabBars.buttons["Bookmarks"]
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

        let homeTab = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTab.waitForExistence(timeout: 10), "Home tab missing")
        homeTab.tap()

        let articlesList = app.otherElements["NewsFeedList"]
        XCTAssertTrue(articlesList.waitForExistence(timeout: 15), "News feed failed to load")

        let firstArticle = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstArticle.waitForExistence(timeout: 10), "No articles found")

        // When
        let articleID = firstArticle.identifier
        print("Testing article with ID: \(articleID)")
        
        firstArticle.tap()

        // Then:
        let backButton = app.navigationBars.buttons["Top Headlines"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 10), "Navigation failed - back button missing")

        let articleTitle = app.staticTexts.matching(identifier: "ArticleTitle_").firstMatch
        XCTAssertTrue(articleTitle.waitForExistence(timeout: 5), "Article title missing")

        let anyDetailElement = app.scrollViews.firstMatch
        XCTAssertTrue(anyDetailElement.waitForExistence(timeout: 5), "No detail content loaded")
    }
    
    func testLoginViewDisplaysCorrectly() {
            // Given
            let loginView = app.otherElements["LoginView"]
            XCTAssertTrue(loginView.exists, "LoginView should be displayed")

            // When
            let loginTitle = app.staticTexts["LoginTitle"]
            let emailField = app.textFields["LoginEmailField"]
            let passwordField = app.secureTextFields["LoginPasswordField"]
            let loginButton = app.buttons["LoginButton"]
            let registerLink = app.buttons["RegisterNavigationLink"]
            let cancelButton = app.buttons["CancelButton"]

            // Then
            XCTAssertTrue(loginTitle.exists, "Login title should be visible")
            XCTAssertTrue(emailField.exists, "Email field should be visible")
            XCTAssertTrue(passwordField.exists, "Password field should be visible")
            XCTAssertTrue(loginButton.exists, "Login button should be visible")
            XCTAssertTrue(registerLink.exists, "Register navigation link should be visible")
            XCTAssertTrue(cancelButton.exists, "Cancel button should be visible")
        }

        func testLoginFunctionality() {
            // Given
            let loginView = app.otherElements["LoginView"]
            XCTAssertTrue(loginView.exists, "LoginView should be displayed")

            let emailField = app.textFields["LoginEmailField"]
            XCTAssertTrue(emailField.exists, "Email field should exist")

            let passwordField = app.secureTextFields["LoginPasswordField"]
            XCTAssertTrue(passwordField.exists, "Password field should exist")

            let loginButton = app.buttons["LoginButton"]
            XCTAssertTrue(loginButton.exists, "Login button should exist")

            // When
            emailField.tap()
            emailField.typeText("user@example.com")

            passwordField.tap()
            passwordField.typeText("password123")

            loginButton.tap()

            // Then
            let loginSuccessAlert = app.alerts.firstMatch
            XCTAssertTrue(loginSuccessAlert.waitForExistence(timeout: 5), "Login success alert should appear")
        }

        func testNavigationToRegisterView() {
            // Given
            let registerLink = app.buttons["RegisterNavigationLink"]
            XCTAssertTrue(registerLink.exists, "Register link should exist")

            // When
            registerLink.tap()

            // Then
            XCTAssertTrue(app.otherElements["RegisterView"].exists, "Should navigate to RegisterView")
        }

        func testCancelLoginView() {
            // Given
            let cancelButton = app.buttons["CancelButton"]
            XCTAssertTrue(cancelButton.exists, "Cancel button should exist")

            // When
            cancelButton.tap()

            // Then
            XCTAssertFalse(app.otherElements["LoginView"].exists, "LoginView should be dismissed")
        }

        func testRegisterViewDisplaysCorrectly() {
            // Given
            let registerView = app.otherElements["RegisterView"]
            XCTAssertTrue(registerView.exists, "RegisterView should be displayed")

            // When
            let registerTitle = app.staticTexts["RegisterTitle"]
            let usernameField = app.textFields["RegisterUsernameField"]
            let emailField = app.textFields["RegisterEmailField"]
            let passwordField = app.secureTextFields["RegisterPasswordField"]
            let confirmPasswordField = app.secureTextFields["RegisterConfirmPasswordField"]
            let registerButton = app.buttons["RegisterButton"]
            let cancelButton = app.buttons["CancelButton"]

            // Then
            XCTAssertTrue(registerTitle.exists, "Register title should be visible")
            XCTAssertTrue(usernameField.exists, "Username field should be visible")
            XCTAssertTrue(emailField.exists, "Email field should be visible")
            XCTAssertTrue(passwordField.exists, "Password field should be visible")
            XCTAssertTrue(confirmPasswordField.exists, "Confirm Password field should be visible")
            XCTAssertTrue(registerButton.exists, "Register button should be visible")
            XCTAssertTrue(cancelButton.exists, "Cancel button should be visible")
        }

        func testRegisterFunctionality() {
            // Given
            let registerView = app.otherElements["RegisterView"]
            XCTAssertTrue(registerView.exists, "RegisterView should be displayed")

            let usernameField = app.textFields["RegisterUsernameField"]
            XCTAssertTrue(usernameField.exists, "Username field should exist")

            let emailField = app.textFields["RegisterEmailField"]
            XCTAssertTrue(emailField.exists, "Email field should exist")

            let passwordField = app.secureTextFields["RegisterPasswordField"]
            XCTAssertTrue(passwordField.exists, "Password field should exist")

            let confirmPasswordField = app.secureTextFields["RegisterConfirmPasswordField"]
            XCTAssertTrue(confirmPasswordField.exists, "Confirm Password field should exist")

            let registerButton = app.buttons["RegisterButton"]
            XCTAssertTrue(registerButton.exists, "Register button should exist")

            // When
            usernameField.tap()
            usernameField.typeText("TestUser")

            emailField.tap()
            emailField.typeText("test@example.com")

            passwordField.tap()
            passwordField.typeText("password123")

            confirmPasswordField.tap()
            confirmPasswordField.typeText("password123")

            registerButton.tap()

            // Then
            let registrationSuccessAlert = app.alerts.firstMatch
            XCTAssertTrue(registrationSuccessAlert.waitForExistence(timeout: 5), "Registration success alert should appear")
        }

        func testCancelRegisterView() {
            // Given
            let cancelButton = app.buttons["CancelButton"]
            XCTAssertTrue(cancelButton.exists, "Cancel button should exist")

            // When
            cancelButton.tap()

            // Then
            XCTAssertFalse(app.otherElements["RegisterView"].exists, "RegisterView should be dismissed")
        }}
