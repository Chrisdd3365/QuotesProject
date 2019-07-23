//
//  MyOwnQuote.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 05/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation
import CoreData

public class MyOwnQuote: NSManagedObject {
    //MARK: - Property
    static var all: [MyOwnQuote] {
        let request: NSFetchRequest<MyOwnQuote> = MyOwnQuote.fetchRequest()
        guard let myOwnQuotes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return myOwnQuotes
    }
}
