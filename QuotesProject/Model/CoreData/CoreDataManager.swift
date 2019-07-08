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
    
        myOwnQuotes.author = author
        myOwnQuotes.quote = quote
        
        saveContext()
        return myOwnQuotes
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
