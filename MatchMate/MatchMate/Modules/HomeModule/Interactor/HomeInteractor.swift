//
//  HomeInteractor.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation

class HomeInteractor {
    weak var presenter: HomeInteractorToPresenterProtocol?
}

extension HomeInteractor: HomePresenterToInteractorProtocol {
    
    @MainActor func fetchUsers() {
        guard let url = URL(string: "https://randomuser.me/api/?results=10") else { return }
        
        Task {
            do {
                let userResponseModel: UserResponse = try await APIManager.shared.getData(fromUrl: url)
                guard let users = userResponseModel.results else { return }
                presenter?.didSuccessfullyReceivedUsers(users)
                
            } catch {
                presenter?.didFailToReceiveUsersData(error)
            }
        }
    }
}
