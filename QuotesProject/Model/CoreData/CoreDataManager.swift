//
//  CoreDataManager.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 05/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    //MARK: - MyOwnQuote CoreDataManager's methods
    static func saveMyOwnQuote(quote: String, author: String) -> MyOwnQuote {
        let myOwnQuotes = MyOwnQuote(context: AppDelegate.viewContext)
    
        myOwnQuotes.quote = quote
        myOwnQuotes.author = author
        
        saveContext()
        return myOwnQuotes
    }
    
    //MARK: - FavoriteQuote CoreDataManager's methods
    //Quote Of The Day
    static func saveQuoteOfTheDayToFavoritesQuotes(contentsQuoteOfTheDay: ContentsQuoteOfTheDay) {
        let favoriteQuote = FavoriteQuote(context: AppDelegate.viewContext)
        
        favoriteQuote.quote = contentsQuoteOfTheDay.contents.quotes[0].quote
        favoriteQuote.author = contentsQuoteOfTheDay.contents.quotes[0].author
        favoriteQuote.backgroundImageURL = contentsQuoteOfTheDay.contents.quotes[0].background
        favoriteQuote.id = contentsQuoteOfTheDay.contents.quotes[0].id
        
        saveContext()
    }
    
    //CategoryQuote
    static func saveCategoryQuoteToFavoritesQuotes(contentsCategoryQuote: ContentsCategoryQuote) {
        let favoriteQuote = FavoriteQuote(context: AppDelegate.viewContext)
        
        favoriteQuote.quote = contentsCategoryQuote.contents.quote
        favoriteQuote.author = contentsCategoryQuote.contents.author
        favoriteQuote.id = contentsCategoryQuote.contents.id
        
        saveContext()
    }
    
    //RandomQuote
    static func saveRandomQuoteToFavoritesQuotes(contentRandomQuote: RandomQuotes) {
        let favoriteQuote = FavoriteQuote(context: AppDelegate.viewContext)
        
        favoriteQuote.quote = contentRandomQuote.content
        favoriteQuote.author = contentRandomQuote.title
        favoriteQuote.id = "\(contentRandomQuote.id)"
        
        saveContext()
    }
    
    static func deleteFavoriteQuoteFromList(id: String, context: NSManagedObjectContext = AppDelegate.viewContext) {
        let fetchRequest: NSFetchRequest<FavoriteQuote> = FavoriteQuote.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id == %@", id)
        
        do {
            let favoritesQuotes = try context.fetch(fetchRequest)
            for favoriteQuote in favoritesQuotes {
                context.delete(favoriteQuote)
            }
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    //MARK: - FavoriteImage CoreDataManager's methods
    static func saveFavoriteImage(contentsImage: ContentsImage) {
        let favoriteImage = FavoriteImage(context: AppDelegate.viewContext)
        
        favoriteImage.id = contentsImage.contents.qimage.id
        favoriteImage.quoteId = contentsImage.contents.qimage.quoteId
        favoriteImage.imageURL = contentsImage.contents.qimage.downloadUri
        
        saveContext()
    }
    
    static func deleteFavoriteImage(id: String, context: NSManagedObjectContext = AppDelegate.viewContext) {
        let fetchRequest: NSFetchRequest<FavoriteImage> = FavoriteImage.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id == %@", id)
        
        do {
            let favoritesImages = try context.fetch(fetchRequest)
            for favoriteImage in favoritesImages {
                context.delete(favoriteImage)
            }
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    //MARK: - Helper's methods
    static func saveContext() {
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
}
