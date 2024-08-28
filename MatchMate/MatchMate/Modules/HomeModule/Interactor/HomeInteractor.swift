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
    }
}

extension HomeInteractor: HomePresenterToInteractorProtocol {
    
    @MainActor func fetchUsers() {
        
        if let users = self.fetchUsersFromDatabaseIfAvailable(),
           !users.isEmpty {
            presenter?.didSuccessfullyReceivedUsers(users)
        } else {
            guard let url = URL(string: "https://randomuser.me/api/?results=10") else { return }
            
            Task {
                do {
                    let userResponseModel: UserResponse = try await APIManager.shared.getData(fromUrl: url)
                    guard let users = userResponseModel.results else { return }
                    coreDataManager?.saveUsersToCoreData(users: users)
                    presenter?.didSuccessfullyReceivedUsers(users)
                } catch {
                    presenter?.didFailToReceiveUsersData(error)
                }
            }
        }
    }
    
    func updateUserInCoreData(user: User) {
        coreDataManager?.updateUserInCoreData(user: user)
    }
}

private extension HomeInteractor {
    
    func fetchUsersFromDatabaseIfAvailable() -> [User]? {
        let users: [User]? = coreDataManager?.fetchAllUsers()
        return users
    }
}
