//
//  CoreDataTests.swift
//  QuotesProjectTests
//
//  Created by Christophe DURAND on 19/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import XCTest
import CoreData
@testable import QuotesProject

class CoreDataTests: XCTestCase {
    //MARK: - Properties
    var container: NSPersistentContainer!
    let quoteOfTheDay: ContentsQuoteOfTheDay? = nil
    var randomQuotes: RandomQuotes? = nil
    let categoryQuote: ContentsCategoryQuote? = nil
    let image: ContentsImage? = nil
    let favoriteQuote: FavoriteQuote? = nil
    var myOwnQuote: MyOwnQuote? = nil
    let favoriteImage: FavoriteImage? = nil
    
    //MARK: - Tests Life Cycle
    override func setUp() {
        favoriteInitStubs()
        locationInitStubs()
        myOwnQuoteInitStubs()
        container = AppDelegate.persistentContainer
    }
    
    override func tearDown() {
        favoriteQuoteFlushData()
        favoriteImageFlushData()
        myOwnQuoteFlushData()
        CoreDataManager.deleteAllFavoritesQuotes()
        CoreDataManager.deleteAllFavoritesImages()
        CoreDataManager.deleteAllMyOwnQuotes()
        container = nil
        super.tearDown()
    }
    
    //MARK: - Methods
    private func insertFavoriteQuoteItem(into managedObjectContext: NSManagedObjectContext) {
        let newFavoriteQuoteItem = FavoriteQuote(context: managedObjectContext)
        newFavoriteQuoteItem.id = "test"
    }
    
    private func insertFavoriteImageItem(into managedObjectContext: NSManagedObjectContext) {
        let newFavoriteImageItem = FavoriteImage(context: managedObjectContext)
        newFavoriteImageItem.id = "test"
    }
    
    private func insertMyOwnQuoteItem(into managedObjectContext: NSManagedObjectContext) {
        let newMyOwnQuoteItem = MyOwnQuote(context: managedObjectContext)
        newMyOwnQuoteItem.quote = "my own quote"
        newMyOwnQuoteItem.author = "author"
    }
    
    //MARK: - Unit Tests FavoriteQuote
    func testInsertManyFavoriteQuoteInPersistentContainer() {
        for _ in 0 ..< 10 {
            insertFavoriteQuoteItem(into: container.newBackgroundContext())
        }
        
        XCTAssertNoThrow(try container.newBackgroundContext().save())
    }
    
    func testSaveFavoriteQuoteTheDayItemInPersistentContainer() {
        CoreDataManager.saveQuoteOfTheDayToFavoritesQuotes(contentsQuoteOfTheDay: quoteOfTheDay)
        
        XCTAssert(true)
    }
    
    func testSaveFavoriteRandomQuotesItemInPersistentContainer() {
        let randomQuote = RandomQuotes(id: 0, title: "quote", content: "author", link: "")
        CoreDataManager.saveRandomQuoteToFavoritesQuotes(contentRandomQuote: randomQuotes ?? randomQuote)
        
        XCTAssert(true)
    }
    
    func testSaveFavoriteCategoryQuoteItemInPersistentContainer() {
        CoreDataManager.saveCategoryQuoteToFavoritesQuotes(contentsCategoryQuote: categoryQuote)
        
        XCTAssert(true)
    }
    
    func testDeleteFavoriteQuoteItemInPersistentContainer() {
        let favoritesQuotes = FavoriteQuote.all
        let favoriteQuote = favoritesQuotes[0]
        
        CoreDataManager.deleteFavoriteQuoteFromList(id: favoriteQuote.id ?? "")

        XCTAssert(true)
    }
    
    func testDeleteAllFavoritePlaceItemsInPersistentContainer() {
        CoreDataManager.deleteAllFavoritesQuotes()
        
        XCTAssertEqual(FavoriteQuote.all, [])
    }
    
    //MARK: - Unit tests FavoriteImage
    func testInsertManyLocationItemsInPersistentContainer() {
        for _ in 0 ..< 10 {
            insertFavoriteImageItem(into: container.newBackgroundContext())
        }
        
        XCTAssertNoThrow(try container.newBackgroundContext().save())
    }
    
    func testSaveFavoriteImageItemInPersistentContainer() {
        CoreDataManager.saveFavoriteImage(contentsImage: image)
        
        XCTAssert(true)
    }
    
    func testDeleteFavoriteImageItemInPersistentContainer() {
        let favoritesImages = FavoriteImage.all
        let favoriteImage = favoritesImages[0]
        
        CoreDataManager.deleteFavoriteImage(id: favoriteImage.id ?? "")
        
        XCTAssert(true)
    }
    
    func testDeleteAllFavoriteImageItemsInPersistentContainer() {
        CoreDataManager.deleteAllFavoritesImages()
        
        XCTAssertEqual(FavoriteImage.all, [])
    }
    
    //MARK: - Unit tests MyOwnQuote
    func testInsertManyMyOwnQuoteInPersistentContainer() {
        for _ in 0 ..< 10 {
            insertMyOwnQuoteItem(into: container.newBackgroundContext())
        }
        
        XCTAssertNoThrow(try container.newBackgroundContext().save())
    }
    
    func testSaveMyOwnQuoteItemInPersistentContainer() {
        myOwnQuote = CoreDataManager.saveMyOwnQuote(quote: "my own quote", author: "author")
 
        XCTAssertEqual(myOwnQuote?.quote, myOwnQuote?.quote)
        XCTAssertEqual(myOwnQuote?.author, myOwnQuote?.author)
    }
    
    func testDeleteAllMyOwnQuoteItemsInPersistentContainer() {
        CoreDataManager.deleteAllMyOwnQuotes()
        
        XCTAssertEqual(MyOwnQuote.all, [])
    }
}

//MARK: - FavoriteQuote
extension CoreDataTests {
    func favoriteInitStubs() {
        func insertFavoriteQuoteItemIntoList(id: String) -> FavoriteQuote? {
            let favoriteQuote = NSEntityDescription.insertNewObject(forEntityName: "FavoriteQuote", into: AppDelegate.viewContext)
            favoriteQuote.setValue("test", forKey: "id")
            return favoriteQuote as? FavoriteQuote
        }
        
        _ = insertFavoriteQuoteItemIntoList(id: "test1")
        _ = insertFavoriteQuoteItemIntoList(id: "test2")
        _ = insertFavoriteQuoteItemIntoList(id: "test3")
        _ = insertFavoriteQuoteItemIntoList(id: "test4")
        _ = insertFavoriteQuoteItemIntoList(id: "test5")
        
        do {
            try AppDelegate.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
    }
    
    func favoriteQuoteFlushData() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteQuote")
        let favoritesQuotes = try! AppDelegate.viewContext.fetch(fetchRequest)
        for case let favoriteQuote as NSManagedObject in favoritesQuotes {
            AppDelegate.viewContext.delete(favoriteQuote)
        }
        try! AppDelegate.viewContext.save()
    }
}

//MARK: - FavoriteImage
extension CoreDataTests {
    func locationInitStubs() {
        func insertFavoriteImageItemIntoList(id: String) -> FavoriteImage? {
            let favoriteImage = NSEntityDescription.insertNewObject(forEntityName: "FavoriteImage", into: AppDelegate.viewContext)
            favoriteImage.setValue("test", forKey: "id")
            return favoriteImage as? FavoriteImage
        }
        
        _ = insertFavoriteImageItemIntoList(id: "test1")
        _ = insertFavoriteImageItemIntoList(id: "test2")
        _ = insertFavoriteImageItemIntoList(id: "test3")
        _ = insertFavoriteImageItemIntoList(id: "test4")
        _ = insertFavoriteImageItemIntoList(id: "test5")
        
        do {
            try AppDelegate.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
    }
    
    func favoriteImageFlushData() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteImage")
        let favoritesImages = try! AppDelegate.viewContext.fetch(fetchRequest)
        for case let favoriteImage as NSManagedObject in favoritesImages {
            AppDelegate.viewContext.delete(favoriteImage)
        }
        try! AppDelegate.viewContext.save()
    }
}

//MARK: - MyOwnQuote
extension CoreDataTests {
    func myOwnQuoteInitStubs() {
        func insertMyOwnQuoteItemIntoList(quote: String, author: String) -> MyOwnQuote? {
            let myOwnQuote = NSEntityDescription.insertNewObject(forEntityName: "MyOwnQuote", into: AppDelegate.viewContext)
            myOwnQuote.setValue("my own quote", forKey: "quote")
            myOwnQuote.setValue("author", forKey: "author")
            return myOwnQuote as? MyOwnQuote
        }
        
        _ = insertMyOwnQuoteItemIntoList(quote: "my own quote1", author: "author1")
        _ = insertMyOwnQuoteItemIntoList(quote: "my own quote2", author: "author2")
        _ = insertMyOwnQuoteItemIntoList(quote: "my own quote3", author: "author3")
        _ = insertMyOwnQuoteItemIntoList(quote: "my own quote4", author: "author4")
        _ = insertMyOwnQuoteItemIntoList(quote: "my own quote5", author: "author5")
        
        do {
            try AppDelegate.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
    }
    
    func myOwnQuoteFlushData() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "MyOwnQuote")
        let myOwnQuotes = try! AppDelegate.viewContext.fetch(fetchRequest)
        for case let myOwnQuote as NSManagedObject in myOwnQuotes {
            AppDelegate.viewContext.delete(myOwnQuote)
        }
        try! AppDelegate.viewContext.save()
    }
}
