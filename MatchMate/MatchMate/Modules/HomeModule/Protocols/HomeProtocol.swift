//
//  HomeProtocol.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation

protocol HomeViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol HomePresenterToRouterProtocol: AnyObject {
    
}

protocol HomePresenterToInteractorProtocol: AnyObject {
    func fetchUsers()
}

protocol HomeInteractorToPresenterProtocol: AnyObject {
    func didSuccessfullyReceivedUsers(_ users: [User])
    func didFailToReceiveUsersData(_ error: Error)
}
