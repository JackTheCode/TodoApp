//
//  CoreDataStack.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation
import CoreData

final class CoreDataStack {

    static let sharedInstance = CoreDataStack()
    private let entityName = "ItemToSell"

    lazy var persistentContainer: CustomPersistantContainer = {
        let container = CustomPersistantContainer(name: entityName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var sellList: [ItemToSell] = [ItemToSell]()

    func store(_ id: Int, name: String, price: Int, quantity: Int, type: Int, createOn: Date) {
        let entity = ItemToSell(context: context)
        entity.id = Int64(id)
        entity.name = name
        entity.price = Int64(price)
        entity.quantity = Int64(quantity)
        entity.type = Int64(type)
        entity.createOn = createOn
        try! context.save()
        debugPrint("storing sell item - before fetch")
        fetch()
    }
    
    func fetch() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let idSort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [idSort]
        sellList = try! context.fetch(fetchRequest) as! [ItemToSell]
    }

    func delete(_ sell: ItemToSell) {
        context.delete(sell)
        try! context.save()
    }

    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

class CustomPersistantContainer: NSPersistentContainer {

    static let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Bundle.main.object(forInfoDictionaryKey: "AppGroupId") as! String)!
    let storeDescription = NSPersistentStoreDescription(url: url)

    override class func defaultDirectoryURL() -> URL {
        return url
    }
    
}
