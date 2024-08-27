//
//  HomePresenter.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation

class HomePresenter: ObservableObject {
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
    @Published var users: [User] = []
}

extension HomePresenter: HomeViewToPresenterProtocol {
    
    func viewDidLoad() {
        fetchData()
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
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
