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
    //MARK: - MyOwnQuotes CoreDataManager's methods
    static func saveMyOwnQuote(quote: String, author: String) -> MyOwnQuote {
        let myOwnQuotes = MyOwnQuote(context: AppDelegate.viewContext)
    
        myOwnQuotes.quote = quote
        myOwnQuotes.author = author
        
        saveContext()
        return myOwnQuotes
    }
    
    //MARK: - FavoritesQuotes CoreDataManager's methods
    static func saveFavoriteQuote(contentsResponse: ContentsResponse) {
        let favoriteQuote = FavoriteQuote(context: AppDelegate.viewContext)
        
        favoriteQuote.quote = contentsResponse.contents.quotes[0].quote
        favoriteQuote.author = contentsResponse.contents.quotes[0].author
        favoriteQuote.backgroundImageURL = contentsResponse.contents.quotes[0].background
        favoriteQuote.id = contentsResponse.contents.quotes[0].id
        
        saveContext()
    }
    
    static func deleteFavoriteFromList(id: String, context: NSManagedObjectContext = AppDelegate.viewContext) {
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
    
    //MARK: - Helper's methods
    static func saveContext() {
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
}
