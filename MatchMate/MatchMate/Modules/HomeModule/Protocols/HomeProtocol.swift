//
//  HomeProtocol.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation

protocol HomeViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
    func handleAcceptAction(for user: User)
    func handleRejectAction(for user: User) 
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
