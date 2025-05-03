//
//  auth_service_appTests.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/27/25.
//
import XCTest
import CoreData
@testable import news_aggerator_app

final class UserAccountTests: XCTestCase {
    var authManager: AuthManager!
        var dao: CoreDataDAO!
        var persistentContainer: NSPersistentContainer!

        override func setUpWithError() throws {
            try super.setUpWithError()
            
            // Setup in-memory Core Data stack
            persistentContainer = NSPersistentContainer(name: "NewsModel")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            persistentContainer.persistentStoreDescriptions = [description]
            
            persistentContainer.loadPersistentStores { (desc, error) in
                if let error = error {
                    fatalError("Failed to load in-memory store: \(error)")
                }
            }
            
            dao = CoreDataDAO()
            authManager = AuthManager()
        }

        override func tearDownWithError() throws {
            dao = nil
            authManager = nil
            persistentContainer = nil
            try super.tearDownWithError()
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
