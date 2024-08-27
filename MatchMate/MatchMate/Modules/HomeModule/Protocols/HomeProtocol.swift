//
//  HomeProtocol.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation

protocol ViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol PresenterToRouterProtocol: AnyObject {
    
}

protocol PresenterToInteractorProtocol: AnyObject {
    func fetchData()
}

protocol InteractorToPresenterProtocol: AnyObject {
    
}
