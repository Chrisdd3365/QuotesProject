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
    static func saveMyOwnQuotes(quote: String, author: String) -> MyOwnQuotes {
        let myOwnQuotes = MyOwnQuotes(context: AppDelegate.viewContext)
    
        myOwnQuotes.quote = quote
        myOwnQuotes.author = author
        
        saveContext()
        return myOwnQuotes
    }
    
    //MARK: - FavoritesQuotes CoreDataManager's methods
    static func saveFavoritesQuotes(quote: String?, author: String?) {
        let favoritesQuotes = FavoritesQuotes(context: AppDelegate.viewContext)
        
        favoritesQuotes.quote = quote
        favoritesQuotes.author = author
        
        saveContext()
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
