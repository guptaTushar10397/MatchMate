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
    @Published var isLoading: Bool = false
}

extension HomePresenter: HomeViewToPresenterProtocol {
    
    func viewDidLoad() {
        fetchData()
    }
    
    func navigateToDetail(for user: User) -> AnyView {
        return AnyView(router?.navigateToDetail(for: user))
    }
    
    func handleAcceptAction(for user: User) {
        guard let indexOfUser = users.firstIndex(where: {$0.id == user.id}) else { return }
        var newObject = users[indexOfUser]
        newObject.userAction = .accepted
        users[indexOfUser] = newObject
        interactor?.updateUserInCoreData(user: newObject)
    }
    
    func handleRejectAction(for user: User) {
        guard let indexOfUser = users.firstIndex(where: {$0.id == user.id}) else { return }
        var newObject = users[indexOfUser]
        newObject.userAction = .rejected
        users[indexOfUser] = newObject
        interactor?.updateUserInCoreData(user: newObject)
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func didSuccessfullyReceivedUsers(_ users: [User]) {
        isLoading = false
        self.users = users.sorted(by: {($0.name?.fullName ?? "").lowercased() < ($1.name?.fullName ?? "").lowercased() })
    }
    
    func didFailToReceiveUsersData(_ error: any Error) {
        isLoading = false
        print("Failed to fetch data, Error: \(error.localizedDescription)")
    }
}

private extension HomePresenter {
    
    func fetchData() {
        isLoading = true
        interactor?.fetchUsers()
    }
}
