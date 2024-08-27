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
    
}

extension HomePresenter: ViewToPresenterProtocol {
    
}

extension HomePresenter: InteractorToPresenterProtocol {
    
}
