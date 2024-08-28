//
//  CoreDataManager.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import Foundation
import CoreData

class WeakReferenceToInteractor: Hashable {
    weak var interactor: CoreDataManagerToInterctorProtocol?

    init(_ interactor: CoreDataManagerToInterctorProtocol) {
        self.interactor = interactor
    }
    
    static func == (lhs: WeakReferenceToInteractor, rhs: WeakReferenceToInteractor) -> Bool {
        return lhs.interactor === rhs.interactor
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(interactor as AnyObject))
    }
}


protocol CoreDataManagerProtocol: AnyObject {
    func registerInteractor(_ interactor: CoreDataManagerToInterctorProtocol)
    func unregisterInteractor(_ interactor: CoreDataManagerToInterctorProtocol)
    func fetchAllUsers() -> [User]
    func fetchUserFor(userID id: String) -> User?
    func saveUsersToCoreData(users: [User])
    func updateUserInCoreData(user: User)
}

protocol CoreDataManagerToInterctorProtocol: AnyObject {
    func coreDataDidUpdate()
}

final class CoreDataManager {
    private let viewContext = CoreDataPersistence.shared.viewContext
    private var interactors: Set<WeakReferenceToInteractor> = []
}

extension CoreDataManager: CoreDataManagerProtocol {
    
    func registerInteractor(_ interactor: CoreDataManagerToInterctorProtocol) {
        interactors.insert(WeakReferenceToInteractor(interactor))
    }
    
    func unregisterInteractor(_ interactor: CoreDataManagerToInterctorProtocol) {
        interactors.remove(WeakReferenceToInteractor(interactor))
    }
    
    func fetchAllUsers() -> [User] {
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        
        do {
            let cdUsers = try viewContext.fetch(fetchRequest)
            return cdUsers.map { CDUserWrapper.convertToUser(cdUser: $0) }
        } catch {
            print("Failed to fetch users from Core Data: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchUserFor(userID id: String) -> User? {
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            
            if let cdUser = results.first {
                return CDUserWrapper.convertToUser(cdUser: cdUser)
            } else {
                return nil
            }
            
        } catch {
            print("Failed to fetch CDUser: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveUsersToCoreData(users: [User]) {
        users.forEach { user in
            _ = CDUserWrapper.convertToCDUser(user: user, context: viewContext)
        }
        
        saveContext()
    }
    
    func updateUserInCoreData(user: User) {
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", user.id)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            
            if let cdUser = results.first {
                // Update the existing CDUser object
                cdUser.userAction = user.userAction?.rawValue
                saveContext()
            }
            
        } catch {
            print("Failed to fetch or update CDUser: \(error.localizedDescription)")
        }
    }
}

private extension CoreDataManager {
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                notifyInteractors() // Notify interactors after saving data
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func notifyInteractors() {
        for weakRef in interactors {
            weakRef.interactor?.coreDataDidUpdate()
        }
    }
}
