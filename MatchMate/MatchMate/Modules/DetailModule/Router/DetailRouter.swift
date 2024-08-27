//
//  DetailRouter.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import SwiftUI

class DetailRouter: DetailPresenterToRouterProtocol {
    
     static func createModule(withUser user: User) -> some View {
        let router = DetailRouter()
        let interactor = DetailInteractor(user)
        let presenter = DetailPresenter()
        
        let view = DetailView(presenter: presenter)
        
        // Dependency Injection
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
