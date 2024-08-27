//
//  HomeRouter.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import SwiftUI

class HomeRouter: PresenterToRouterProtocol {
    
    static func createModule() -> some View {
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        
        let view = HomeView(presenter: presenter)
        
        // Dependency Injection
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
