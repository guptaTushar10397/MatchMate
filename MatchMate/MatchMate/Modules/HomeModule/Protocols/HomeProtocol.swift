//
//  HomeProtocol.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation
import SwiftUI

protocol HomeViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
    func handleAcceptAction(for user: User)
    func handleRejectAction(for user: User) 
    func navigateToDetail(for user: User) -> AnyView
}

protocol HomePresenterToRouterProtocol: AnyObject {
    func navigateToDetail(for user: User) -> AnyView
}

protocol HomePresenterToInteractorProtocol: AnyObject {
    func fetchUsers()
    func updateUserInCoreData(user: User)
}

protocol HomeInteractorToPresenterProtocol: AnyObject {
    func didSuccessfullyReceivedUsers(_ users: [User])
    func didFailToReceiveUsersData(_ error: Error)
}
