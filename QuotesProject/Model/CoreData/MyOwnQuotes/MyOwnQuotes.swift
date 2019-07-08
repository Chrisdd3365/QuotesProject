//
//  MyOwnQuotes.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 05/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation
import CoreData

public class MyOwnQuotes: NSManagedObject {
    //MARK: - Property
    static var all: [MyOwnQuotes] {
        let request: NSFetchRequest<MyOwnQuotes> = MyOwnQuotes.fetchRequest()
        guard let myOwnQuotes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return myOwnQuotes
    }
}
