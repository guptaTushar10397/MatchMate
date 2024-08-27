//
//  HomePresenter.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation
import SwiftUI

class HomePresenter: ObservableObject {
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
    @Published var users: [User] = []
    
    private var hasLoaded: Bool = false
}

extension HomePresenter: HomeViewToPresenterProtocol {
    
    func viewDidLoad() {
        guard !hasLoaded else { return }
        hasLoaded = true
        
        fetchData()
    }
    
    func navigateToDetail(for user: User) -> AnyView {
        return AnyView(router?.navigateToDetail(for: user))
    }
    
    func handleAcceptAction(for user: User) {
        guard let indexOfUser = users.firstIndex(where: {$0.id == user.id}) else {
            return
        }
        var newObject = users[indexOfUser]
        newObject.userAction = .accepted
        users[indexOfUser] = newObject
    }
    
    func handleRejectAction(for user: User) {
        guard let indexOfUser = users.firstIndex(where: {$0.id == user.id}) else {
            return
        }
        var newObject = users[indexOfUser]
        newObject.userAction = .rejected
        users[indexOfUser] = newObject
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
