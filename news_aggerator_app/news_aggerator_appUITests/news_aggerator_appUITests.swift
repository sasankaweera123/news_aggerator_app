//
//  news_aggerator_appUITests.swift
//  news_aggerator_appUITests
//
//  Created by user270598 on 4/16/25.
//

import XCTest

final class news_aggerator_appUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
    }
    
    func testWelcomeViewDismissesToContentView() {
        // Given
        let title = app.staticTexts["Welcome to News Aggregator App"]
        let subtitle = app.staticTexts["Your one-stop hub for the latest headlines!"]
        let continueButton = app.buttons["Continue"]
        
        XCTAssertTrue(title.exists, "Title should be displayed")
        XCTAssertTrue(subtitle.exists, "Subtitle should be displayed")
        XCTAssertTrue(continueButton.exists, "Continue button should exist")
        
        // When
        continueButton.tap()
        
        // Then
        XCTAssertFalse(title.exists, "WelcomeView should be dismissed")
        XCTAssertFalse(subtitle.exists, "WelcomeView should be dismissed")
        XCTAssertFalse(continueButton.exists, "WelcomeView should be dismissed")
        
        XCTAssertTrue(app.tabBars.count > 0, "ContentView should be displayed")
    }
    
    func testTabNavigation() {
        // Given
        let homeTab = app.tabBars.buttons["Home"]
        let searchTab = app.tabBars.buttons["Search"]
        let bookmarksTab = app.tabBars.buttons["Bookmarks"]
        
        XCTAssertTrue(homeTab.exists, "Home tab should exist")
        XCTAssertTrue(searchTab.exists, "Search tab should exist")
        XCTAssertTrue(bookmarksTab.exists, "Bookmarks tab should exist")
        
        // When & Then
        homeTab.tap()
        XCTAssertTrue(app.navigationBars["Home"].exists, "Should navigate to Home view")
        
        searchTab.tap()
        XCTAssertTrue(app.navigationBars["Search"].exists, "Should navigate to Search view")
        
        bookmarksTab.tap()
        XCTAssertTrue(app.navigationBars["Bookmarks"].exists, "Should navigate to Bookmarks view")
    }
    
    func testArticleListDisplaysCorrectly() {
        // Given
        let homeTab = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTab.exists, "Home tab should exist")
        homeTab.tap()
        
        let newsFeedView = app.otherElements["NewsFeedView"]
        XCTAssertTrue(newsFeedView.exists, "NewsFeedView should be displayed")
        
        let firstArticle = app.cells.firstMatch
        XCTAssertTrue(firstArticle.exists, "At least one article should be displayed")
        
        XCTAssertTrue(app.staticTexts.firstMatch.exists, "Article title should be visible")
        XCTAssertTrue(app.staticTexts.firstMatch.exists, "Article source should be visible")
        
        let firstBookmarkButton = app.buttons.matching(identifier: "BookmarkButton").firstMatch
        XCTAssertTrue(firstBookmarkButton.exists, "Bookmark button should exist")
    }
    
    func testArticleRowDisplaysCorrectly() {
        // Given
        let homeTab = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTab.exists, "Home tab should exist")
        homeTab.tap()
        
        let firstArticleRow = app.otherElements.matching(identifier: "ArticleRow").firstMatch
        XCTAssertTrue(firstArticleRow.exists, "Article row should be displayed")
        
        let firstTitle = app.staticTexts.matching(identifier: "ArticleTitle").firstMatch
        XCTAssertTrue(firstTitle.exists, "Article title should be visible")
        
        let firstSource = app.staticTexts.matching(identifier: "ArticleSource").firstMatch
        XCTAssertTrue(firstSource.exists, "Article source should be visible")
        
        let firstImage = app.images.matching(identifier: "ArticleImage").firstMatch
        XCTAssertTrue(firstImage.exists || app.images.matching(identifier: "PlaceholderImage").firstMatch.exists, "Article image should be displayed or a placeholder should be present")
    }
    
    func testArticleNavigation() {
        // Given
        let homeTab = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTab.exists, "Home tab should exist")
        homeTab.tap()
        
        let firstArticleRow = app.otherElements.matching(identifier: "ArticleRow").firstMatch
        XCTAssertTrue(firstArticleRow.exists, "Article row should be displayed")
        
        // When
        firstArticleRow.tap()
        
        // Then
        XCTAssertTrue(app.navigationBars.firstMatch.exists, "Should navigate to Article Detail view")
        
        // Navigate back
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(app.otherElements.matching(identifier: "NewsFeedView").firstMatch.exists, "Should return to NewsFeedView")
    }
    
    func testSearchViewDisplaysCorrectly() {
        // Given
        let searchTab = app.tabBars.buttons["Search"]
        XCTAssertTrue(searchTab.exists, "Search tab should exist")
        searchTab.tap()
        
        let searchView = app.otherElements["SearchView"]
        XCTAssertTrue(searchView.exists, "SearchView should be displayed")
        XCTAssertTrue(app.textFields["SearchTextField"].exists, "Search text field should be visible")
    }
    
    func testSearchFunctionality() {
        // Given
        let searchTab = app.tabBars.buttons["Search"]
        XCTAssertTrue(searchTab.exists, "Search tab should exist")
        searchTab.tap()
        
        let searchTextField = app.textFields["SearchTextField"]
        XCTAssertTrue(searchTextField.exists, "Search text field should exist")
        
        // When
        searchTextField.tap()
        searchTextField.typeText("Technology News\n")
        
        // Then
        let searchResult = app.cells.matching(identifier: "SearchResult").firstMatch
        XCTAssertTrue(searchResult.waitForExistence(timeout: 5), "Search results should appear")
    }
    
    func testSearchResultNavigation() {
        // Given
        let searchTab = app.tabBars.buttons["Search"]
        XCTAssertTrue(searchTab.exists, "Search tab should exist")
        searchTab.tap()
        
        let searchTextField = app.textFields["SearchTextField"]
        XCTAssertTrue(searchTextField.exists, "Search text field should exist")
        
        searchTextField.tap()
        searchTextField.typeText("Latest Headlines\n")
        
        let searchResult = app.cells.matching(identifier: "SearchResult").firstMatch
        XCTAssertTrue(searchResult.waitForExistence(timeout: 5), "Search results should appear")
        
        // When
        searchResult.tap()
        
        // Then
        XCTAssertTrue(app.navigationBars.firstMatch.exists, "Should navigate to Article Detail view")
        
        // Navigate back
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(app.otherElements["SearchView"].exists, "Should return to SearchView")
    }
    
    func testBookmarksViewDisplaysCorrectly() {
        // Given
        let bookmarksTab = app.tabBars.buttons["Bookmarks"]
        XCTAssertTrue(bookmarksTab.exists, "Bookmarks tab should exist")
        
        // When
        bookmarksTab.tap()
        
        // Then
        let bookmarksView = app.otherElements["BookmarksView"]
        XCTAssertTrue(bookmarksView.exists, "BookmarksView should be displayed")
        XCTAssertTrue(app.staticTexts["BookmarksTitle"].exists, "Bookmarks title should be visible")
    }
    
    func testBookmarkListDisplaysCorrectly() {
        let bookmarksTab = app.tabBars.buttons["Bookmarks"]
        XCTAssertTrue(bookmarksTab.exists, "Bookmarks tab should exist")
        bookmarksTab.tap()
        
        let firstBookmark = app.cells.firstMatch
        XCTAssertTrue(firstBookmark.exists, "At least one bookmarked article should be displayed")
    }
    
    func testBookmarkDeletion() {
        let bookmarksTab = app.tabBars.buttons["Bookmarks"]
        XCTAssertTrue(bookmarksTab.exists, "Bookmarks tab should exist")
        bookmarksTab.tap()
        
        let firstBookmarkRow = app.otherElements.matching(identifier: "BookmarkRow").firstMatch
        XCTAssertTrue(firstBookmarkRow.exists, "At least one bookmark should exist")
        
        let removeBookmarkButton = app.buttons.matching(identifier: "RemoveBookmarkButton").firstMatch
        XCTAssertTrue(removeBookmarkButton.exists, "Remove bookmark button should exist")
        
        // When
        removeBookmarkButton.tap()
        
        // Then
        XCTAssertFalse(firstBookmarkRow.exists, "The bookmark should be removed")
    }
    
    func testBookmarksEmptyState() {
        let bookmarksTab = app.tabBars.buttons["Bookmarks"]
        XCTAssertTrue(bookmarksTab.exists, "Bookmarks tab should exist")
        bookmarksTab.tap()
        
        let noBookmarksMessage = app.staticTexts["NoBookmarksMessage"]
        XCTAssertTrue(noBookmarksMessage.exists, "No bookmarked articles message should be displayed")
    }
    
    func testArticleDetailViewDisplaysCorrectly() {
        let homeTab = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTab.exists, "Home tab should exist")
        homeTab.tap()
        
        let firstArticleRow = app.otherElements.matching(identifier: "ArticleRow").firstMatch
        XCTAssertTrue(firstArticleRow.exists, "Article row should be displayed")
        
        // Navigate to Article Detail View
        firstArticleRow.tap()
        
        let articleDetailView = app.otherElements["ArticleDetailView"]
        XCTAssertTrue(articleDetailView.exists, "ArticleDetailView should be displayed")
        XCTAssertTrue(app.staticTexts.matching(identifier: "ArticleTitle").firstMatch.exists, "Article title should be visible")
        XCTAssertTrue(app.staticTexts.matching(identifier: "ArticleSource").firstMatch.exists, "Article source should be visible")
        XCTAssertTrue(app.buttons.matching(identifier: "BookmarkButton").firstMatch.exists, "Bookmark button should be visible")
        XCTAssertTrue(app.buttons.matching(identifier: "ReadFullArticleButton").firstMatch.exists, "Read Full Article button should be visible")
        
        // Navigate back
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(app.otherElements["NewsFeedView"].exists, "Should return to NewsFeedView")
    }
    
    func testBookmarkFunctionalityInArticleDetail() {
        let homeTab = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTab.exists, "Home tab should exist")
        homeTab.tap()
        
        let firstArticleRow = app.otherElements.matching(identifier: "ArticleRow").firstMatch
        XCTAssertTrue(firstArticleRow.exists, "Article row should be displayed")
        
        // Navigate to Article Detail View
        firstArticleRow.tap()
        
        let bookmarkButton = app.buttons.matching(identifier: "BookmarkButton").firstMatch
        XCTAssertTrue(bookmarkButton.exists, "Bookmark button should be visible")
        
        // Tap bookmark
        bookmarkButton.tap()
        XCTAssertTrue(bookmarkButton.exists, "Bookmark button should still exist after tap")
        
        // Navigate back to bookmarks tab
        let bookmarksTab = app.tabBars.buttons["Bookmarks"]
        bookmarksTab.tap()
        
        let firstBookmarkRow = app.otherElements.matching(identifier: "BookmarkRow").firstMatch
        XCTAssertTrue(firstBookmarkRow.exists, "Bookmarked article should be listed in bookmarks")
        
        // Remove the bookmark
        let removeBookmarkButton = app.buttons.matching(identifier: "RemoveBookmarkButton").firstMatch
        XCTAssertTrue(removeBookmarkButton.exists, "Remove bookmark button should exist")
        removeBookmarkButton.tap()
        
        XCTAssertFalse(firstBookmarkRow.exists, "Bookmark should be removed")
    }
    
    func testLoginViewDisplaysCorrectly() {
        let loginView = app.otherElements["LoginView"]
        XCTAssertTrue(loginView.exists, "LoginView should be displayed")

        XCTAssertTrue(app.staticTexts["LoginTitle"].exists, "Login title should be visible")
        XCTAssertTrue(app.textFields["LoginEmailField"].exists, "Email field should be visible")
        XCTAssertTrue(app.secureTextFields["LoginPasswordField"].exists, "Password field should be visible")
        XCTAssertTrue(app.buttons["LoginButton"].exists, "Login button should be visible")
        XCTAssertTrue(app.buttons["RegisterNavigationLink"].exists, "Register navigation link should be visible")
        XCTAssertTrue(app.buttons["CancelButton"].exists, "Cancel button should be visible")
    }

    func testLoginFunctionality() {
        let loginView = app.otherElements["LoginView"]
        XCTAssertTrue(loginView.exists, "LoginView should be displayed")

        let emailField = app.textFields["LoginEmailField"]
        XCTAssertTrue(emailField.exists, "Email field should exist")
        emailField.tap()
        emailField.typeText("user@example.com")

        let passwordField = app.secureTextFields["LoginPasswordField"]
        XCTAssertTrue(passwordField.exists, "Password field should exist")
        passwordField.tap()
        passwordField.typeText("password123")

        let loginButton = app.buttons["LoginButton"]
        XCTAssertTrue(loginButton.exists, "Login button should exist")
        
        // When tapping login
        loginButton.tap()
        
        // Then: Check if login success alert appears
        let loginSuccessAlert = app.alerts.firstMatch
        XCTAssertTrue(loginSuccessAlert.waitForExistence(timeout: 5), "Login success alert should appear")
    }

    func testNavigationToRegisterView() {
        let registerLink = app.buttons["RegisterNavigationLink"]
        XCTAssertTrue(registerLink.exists, "Register link should exist")

        registerLink.tap()

        XCTAssertTrue(app.otherElements["RegisterView"].exists, "Should navigate to RegisterView")
    }

    func testCancelLoginView() {
        let cancelButton = app.buttons["CancelButton"]
        XCTAssertTrue(cancelButton.exists, "Cancel button should exist")

        cancelButton.tap()

        XCTAssertFalse(app.otherElements["LoginView"].exists, "LoginView should be dismissed")
    }
    
    func testRegisterViewDisplaysCorrectly() {
        let registerView = app.otherElements["RegisterView"]
        XCTAssertTrue(registerView.exists, "RegisterView should be displayed")

        XCTAssertTrue(app.staticTexts["RegisterTitle"].exists, "Register title should be visible")
        XCTAssertTrue(app.textFields["RegisterUsernameField"].exists, "Username field should be visible")
        XCTAssertTrue(app.textFields["RegisterEmailField"].exists, "Email field should be visible")
        XCTAssertTrue(app.secureTextFields["RegisterPasswordField"].exists, "Password field should be visible")
        XCTAssertTrue(app.secureTextFields["RegisterConfirmPasswordField"].exists, "Confirm Password field should be visible")
        XCTAssertTrue(app.buttons["RegisterButton"].exists, "Register button should be visible")
        XCTAssertTrue(app.buttons["CancelButton"].exists, "Cancel button should be visible")
    }

    func testRegisterFunctionality() {
        let registerView = app.otherElements["RegisterView"]
        XCTAssertTrue(registerView.exists, "RegisterView should be displayed")

        let usernameField = app.textFields["RegisterUsernameField"]
        XCTAssertTrue(usernameField.exists, "Username field should exist")
        usernameField.tap()
        usernameField.typeText("TestUser")

        let emailField = app.textFields["RegisterEmailField"]
        XCTAssertTrue(emailField.exists, "Email field should exist")
        emailField.tap()
        emailField.typeText("test@example.com")

        let passwordField = app.secureTextFields["RegisterPasswordField"]
        XCTAssertTrue(passwordField.exists, "Password field should exist")
        passwordField.tap()
        passwordField.typeText("password123")

        let confirmPasswordField = app.secureTextFields["RegisterConfirmPasswordField"]
        XCTAssertTrue(confirmPasswordField.exists, "Confirm Password field should exist")
        confirmPasswordField.tap()
        confirmPasswordField.typeText("password123")

        let registerButton = app.buttons["RegisterButton"]
        XCTAssertTrue(registerButton.exists, "Register button should exist")
        
        // When tapping register
        registerButton.tap()
        
        // Then: Check if registration success alert appears
        let registrationSuccessAlert = app.alerts.firstMatch
        XCTAssertTrue(registrationSuccessAlert.waitForExistence(timeout: 5), "Registration success alert should appear")
    }

    func testCancelRegisterView() {
        let cancelButton = app.buttons["CancelButton"]
        XCTAssertTrue(cancelButton.exists, "Cancel button should exist")

        cancelButton.tap()

        XCTAssertFalse(app.otherElements["RegisterView"].exists, "RegisterView should be dismissed")
    }

}
