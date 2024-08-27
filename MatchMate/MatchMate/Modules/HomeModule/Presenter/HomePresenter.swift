//
//  HomePresenter.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation

class HomePresenter: ObservableObject {
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    @Published var users: [User] = []
}

extension HomePresenter: ViewToPresenterProtocol {
    
    func viewDidLoad() {
        fetchData()
    }
}

extension HomePresenter: InteractorToPresenterProtocol {
    func didSuccessfullyReceivedUsers(_ users: [User]) {
        self.users = users
    }
    
    func didFailToReceiveUsersData(_ error: any Error) {
        print("Failed to fetch data, Error: \(error.localizedDescription)")
    }
}

private extension HomePresenter {
    
    func fetchData() {
        interactor?.fetchUsers()
    }
}
