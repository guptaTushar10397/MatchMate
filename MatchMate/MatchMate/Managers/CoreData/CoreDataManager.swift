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
