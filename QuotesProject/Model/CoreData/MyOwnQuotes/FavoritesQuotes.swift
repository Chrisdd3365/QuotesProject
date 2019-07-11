//
//  FavoritesQuotes.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 10/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation
import CoreData

class FavoritesQuotes: NSManagedObject {
    //MARK: - Property
    static var all: [FavoritesQuotes] {
        let request: NSFetchRequest<FavoritesQuotes> = FavoritesQuotes.fetchRequest()
        guard let favoritesQuotes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favoritesQuotes
    }
}
