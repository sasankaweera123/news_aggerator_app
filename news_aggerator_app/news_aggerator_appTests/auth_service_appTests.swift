//
//  auth_service_appTests.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/27/25.
//
import XCTest
@testable import news_aggerator_app

final class UserAccount:XCTestCase{
    var authManager: AuthManager!
    var dao: CoreDataDAO!
    
    override func setUpWithError() throws {
        authManager = AuthManager()
        dao = CoreDataDAO()
    }
    
    override func tearDownWithError() throws {
        authManager = nil
        dao = nil
    }
    
    func testSaveAndFetchUser() throws {
        let email = "testuser@example.com"
        let password = "password123"
        let username = "TestUser"
        
        // Save user
        dao.saveUser(username: username, email: email, password: password)
        
        // Fetch user
        let fetchedUser = dao.fetchUser(byEmail: email)
        XCTAssertNotNil(fetchedUser)
        XCTAssertEqual(fetchedUser?.email, email)
        XCTAssertEqual(fetchedUser?.password, password)
    }
    
    func testVerifyLoginSuccess() throws {
        let email = "loginuser@example.com"
        let password = "securepass"
        let username = "LoginUser"
        
        dao.saveUser(username: username, email: email, password: password)
        
        let loginSuccess = dao.verifyLogin(email: email, password: password)
        XCTAssertTrue(loginSuccess)
    }
    
    func testVerifyLoginFailureWrongPassword() throws {
        let email = "wrongpassuser@example.com"
        let password = "correctpass"
        let username = "WrongPassUser"
        
        dao.saveUser(username: username, email: email, password: password)
        
        let loginFailure = dao.verifyLogin(email: email, password: "wrongpass")
        XCTAssertFalse(loginFailure)
    }
    
    func testRegisterNewUserSuccess() throws {
        let result = authManager.register(username: "NewUser", email: "newuser@example.com", password: "newpassword")
        XCTAssertTrue(result)
    }
    
    func testRegisterDuplicateEmailFailure() throws {
        let email = "duplicate@example.com"
        let password = "password"
        let username = "DuplicateUser"
        
        _ = authManager.register(username: username, email: email, password: password)
        let secondRegister = authManager.register(username: "AnotherUser", email: email, password: "anotherpass")
        
        XCTAssertFalse(secondRegister)
    }
}
