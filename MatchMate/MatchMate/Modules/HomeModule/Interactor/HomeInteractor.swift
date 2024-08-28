//
//  HomeInteractor.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation

class HomeInteractor {
    weak var presenter: HomeInteractorToPresenterProtocol?
    var coreDataManager: CoreDataManagerProtocol?
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
        if let manager = coreDataManager as? CoreDataManager {
            manager.registerInteractor(self)
        }
    }
    
    deinit {
        if let manager = coreDataManager as? CoreDataManager {
            manager.unregisterInteractor(self)
        }
    }
}

extension HomeInteractor: HomePresenterToInteractorProtocol {
    
    @MainActor func fetchUsers() {
        
        fetchUsersFromDBIfAvailable()
        
        guard let url = URL(string: "https://randomuser.me/api/?results=10") else { return }
        
        Task {
            do {
                let userResponseModel: UserResponse = try await APIManager.shared.getData(fromUrl: url)
                guard let users = userResponseModel.results else { return }
                coreDataManager?.saveUsersToCoreData(users: users)
            } catch {
                presenter?.didFailToReceiveUsersData(error)
            }
        }
    }
    
    func updateUserInCoreData(user: User) {
        coreDataManager?.updateUserInCoreData(user: user)
    }
}

extension HomeInteractor: CoreDataManagerToInterctorProtocol {
    
    func coreDataDidUpdate() {
        fetchUsersFromDBIfAvailable()
    }
}

private extension HomeInteractor {
    
    func fetchUsersFromDBIfAvailable() {
        let savedUsers = getUsersFromDB()
        
        if !savedUsers.isEmpty {
            presenter?.didSuccessfullyReceivedUsers(savedUsers)
        }
    }
    
    func getUsersFromDB() -> [User] {
        let users: [User] = coreDataManager?.fetchAllUsers() ?? []
        return users
    }
}
