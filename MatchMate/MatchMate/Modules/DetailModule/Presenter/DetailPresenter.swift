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
}

extension DetailPresenter: DetailViewToPresenterProtocol {
    
}

extension DetailPresenter: DetailInteractorToPresenterProtocol {
    
}
