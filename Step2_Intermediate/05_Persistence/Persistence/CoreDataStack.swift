//
//  CoreDataStack.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/25/25.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "PersistenceModel")
        container.loadPersistentStores { _, error in
            if let error { fatalError(error.localizedDescription) }
        }
    }
}
