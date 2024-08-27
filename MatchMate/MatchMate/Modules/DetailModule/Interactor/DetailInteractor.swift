//
//  DetailInteractor.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import Foundation

class DetailInteractor {
    weak var presenter: DetailInteractorToPresenterProtocol?
    private var user: User
    
    init(_ user: User) {
        self.user = user
    }
    
}

extension DetailInteractor: DetailPresenterToInteractorProtocol {
    
    func fetchUser() {
        presenter?.didSuccessfullyReceivedUser(self.user)
    }
}
