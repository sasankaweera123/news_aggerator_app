//
//  core_data_dao_test.swift
//  news_aggerator_appTests
//
//  Created by user270598 on 5/3/25.
//

import XCTest
import CoreData
@testable import news_aggerator_app

final class CoreDataDAOTests: XCTestCase {
    
    var coreDataDAO: CoreDataDAO!
    var mockContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        let container = NSPersistentContainer(name: "NewsModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        let expectation = self.expectation(description: "Load persistent stores")
        container.loadPersistentStores { _, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        mockContext = container.viewContext
        coreDataDAO = CoreDataDAO()
    }

    
    override func tearDown() {
        coreDataDAO = nil
        mockContext = nil
        super.tearDown()
    }
    
    func makeSampleArticle() -> NewsArticle {
        return NewsArticle(
            id: UUID(),
            title: "Test Title",
            description: "Description",
            url: "http://test.com",
            urlToImage: nil,
            publishedAt: "2024-05-01",
            content: nil,
            source: NewsArticle.Source(id: nil, name: "UnitTest")
        )
    }
    
    func testSaveBookmark_shouldSaveSuccessfully() {
        let article = makeSampleArticle()
        coreDataDAO.saveBookmark(article: article)
        let fetched = coreDataDAO.fetchBookmarks()
        XCTAssertGreaterThan(fetched.count, 0)
    }
    
    func testDeleteBookmark_shouldRemoveBookmark() {
        let article = makeSampleArticle()
        coreDataDAO.saveBookmark(article: article)

        // Confirm article is saved
        var fetched = coreDataDAO.fetchBookmarks()
        XCTAssertTrue(fetched.contains(where: { $0.id == article.id }))

        // Delete the article
        coreDataDAO.deleteBookmark(id: article.id)

        // Fetch again and verify the deleted article is no longer present
        fetched = coreDataDAO.fetchBookmarks()
        XCTAssertFalse(fetched.contains(where: { $0.id == article.id }))
    }

    
    func testIsArticleBookmarked_shouldReturnCorrectStatus() {
        let article = makeSampleArticle()
        XCTAssertFalse(coreDataDAO.isArticleBookmarked(article: article))
        coreDataDAO.saveBookmark(article: article)
        XCTAssertTrue(coreDataDAO.isArticleBookmarked(article: article))
    }
    
}
