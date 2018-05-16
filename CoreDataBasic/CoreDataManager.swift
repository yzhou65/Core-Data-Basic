//
//  CoreDataManager.swift
//  CoreDataBasic
//
//  Created by Yue Zhou on 5/15/18.
//  Copyright © 2018 Yue Zhou. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    // MARK: - Singleton
    private override init() {}
    private static let manager = CoreDataManager()
    
    class func shared() -> CoreDataManager {
        return CoreDataManager.manager
    }
    
    // MARK: - Data operations
    
    /**
     * Except for query, all other data operations (add, delete, update) needs to save context
     */
    private func saveContext() {
        do {
            try self.context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    
    /**
     * Get all persons
     */
    func getAllPersons() -> [Person] {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            let result = try self.context.fetch(fetchRequest)
            return result
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    /**
     * Get persons using the name
     */
    func getPerson(named: String) -> [Person] {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", named)
        
        do {
            let result = try self.context.fetch(fetchRequest)
            return result
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    /**
     * add a person
     */
    func addPerson(with name: String, age: Int16) -> Person {
        let p = NSEntityDescription.insertNewObject(forEntityName: "Person", into: self.context) as! Person
        p.name = name
        p.age = age
        self.saveContext()
        return p
    }
    
    
    /**
     * Update person
     */
    func updatePersons(named: String, with newName: String, newAge: Int16) {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", named)
        
        do {
            let persons = try self.context.fetch(fetchRequest)
            for p in persons {
                // update persons
                p.name = newName
                p.age = newAge
            }
            
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        self.saveContext()
    }
    
    /**
     * conditioned delete
     */
    func delete(person: Person) {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", person.name!)
        do {
            let persons = try self.context.fetch(fetchRequest)
            for (i, p) in persons.enumerated() {
                // delete persons
                self.context.delete(p)
            }
            
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        saveContext()
    }
    
    /**
     * delete all
     */
    func deleteAllPersons() {
        let persons = self.getAllPersons()
        for person in persons {
            self.context.delete(person)
        }
        saveContext()
    }
    
    
    // MARK: - lazy init
    //  NSManagedObjectContext
    private lazy var context: NSManagedObjectContext = {
        let context = (UIApplication.shared.delegate as! AppDelegate).context
        return context
    }()
}
