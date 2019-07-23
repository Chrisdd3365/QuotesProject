//
//  FavoritesQuotes.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 10/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation
import CoreData

class FavoriteQuote: NSManagedObject {
    //MARK: - Property
    static var all: [FavoriteQuote] {
        let request: NSFetchRequest<FavoriteQuote> = FavoriteQuote.fetchRequest()
        guard let favoritesQuotes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favoritesQuotes
    }
}
