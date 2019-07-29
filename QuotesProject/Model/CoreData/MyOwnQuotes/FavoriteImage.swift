//
//  FavoriteImage.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 29/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation
import CoreData

public class FavoriteImage: NSManagedObject {
    //MARK: - Property
    static var all: [FavoriteImage] {
        let request: NSFetchRequest<FavoriteImage> = FavoriteImage.fetchRequest()
        guard let favoritesImages = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favoritesImages
    }
}
