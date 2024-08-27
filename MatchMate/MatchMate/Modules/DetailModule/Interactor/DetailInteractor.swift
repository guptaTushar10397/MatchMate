//
//  DetailInteractor.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import Foundation

class DetailInteractor {
    weak var presenter: DetailInteractorToPresenterProtocol?
}

extension DetailInteractor: DetailPresenterToInteractorProtocol {
    
}
