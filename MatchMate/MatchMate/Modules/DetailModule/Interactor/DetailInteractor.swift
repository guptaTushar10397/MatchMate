//
//  DetailInteractor.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import Foundation

class DetailInteractor {
    weak var presenter: DetailInteractorToPresenterProtocol?
    var coreDataManager: CoreDataManagerProtocol?
    
    private var userID: String
    
    init(_ userID: String, coreDataManager: CoreDataManagerProtocol) {
        self.userID = userID
        self.coreDataManager = coreDataManager
    }
}

extension DetailInteractor: DetailPresenterToInteractorProtocol {
    
    func fetchUser() {
        guard let user = coreDataManager?.fetchUserFor(userID: userID) else { return }
        presenter?.didSuccessfullyReceivedUser(user)
    }
    
    func updateUserInCoreData(user: User) {
        coreDataManager?.updateUserInCoreData(user: user)
    }
}

