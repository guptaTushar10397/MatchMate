//
//  DetailProtocol.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import Foundation

protocol DetailViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewDidTapOnAcceptActionButton()
    func viewDidTapOnRejectActionButton()
}

protocol DetailPresenterToRouterProtocol: AnyObject {
    
}

protocol DetailPresenterToInteractorProtocol: AnyObject {
    func fetchUser()
    func updateUserInCoreData(user: User)
}

protocol DetailInteractorToPresenterProtocol: AnyObject {
    func didSuccessfullyReceivedUser(_ user: User)
}
