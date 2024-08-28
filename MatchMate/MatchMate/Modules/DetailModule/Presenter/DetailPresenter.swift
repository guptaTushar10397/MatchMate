//
//  DetailPresenter.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import Foundation

class DetailPresenter: ObservableObject {
    var interactor: DetailPresenterToInteractorProtocol?
    var router: DetailPresenterToRouterProtocol?
    
    @Published var user: User? = nil
}

extension DetailPresenter: DetailViewToPresenterProtocol {
    
    func viewDidLoad() {
        interactor?.fetchUser()
    }
    
    func viewDidTapOnAcceptActionButton() {
        guard let user = self.user else { return }
        var newObject = user
        newObject.userAction = .accepted
        self.user = newObject
        interactor?.updateUserInCoreData(user: newObject)
    }
    
    func viewDidTapOnRejectActionButton() {
        guard let user = self.user else { return }
        var newObject = user
        newObject.userAction = .rejected
        self.user = newObject
        interactor?.updateUserInCoreData(user: newObject)
    }
}

extension DetailPresenter: DetailInteractorToPresenterProtocol {
    
    func didSuccessfullyReceivedUser(_ user: User) {
        self.user = user
    }
}
