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
}

extension DetailPresenter: DetailInteractorToPresenterProtocol {
    
    func didSuccessfullyReceivedUser(_ user: User) {
        self.user = user
    }
}
