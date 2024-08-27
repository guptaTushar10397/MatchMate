//
//  HomeInteractor.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation

class HomeInteractor {
    weak var presenter: InteractorToPresenterProtocol?
}

extension HomeInteractor: PresenterToInteractorProtocol {
    
    func fetchData() {
        // TODO: API Calls
    }
}
