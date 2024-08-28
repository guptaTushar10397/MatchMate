//
//  HomeRouter.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import SwiftUI

class HomeRouter {
    
    static func createModule() -> some View {
        let router = HomeRouter()
        let presenter = HomePresenter()
        let coreDataManager = CoreDataManager()
        let interactor = HomeInteractor(coreDataManager: coreDataManager)
        let view = HomeView(presenter: presenter)
        
        // Dependency Injection
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}

extension HomeRouter: HomePresenterToRouterProtocol {
    
    func navigateToDetail(for user: User) -> AnyView {
        return AnyView(DetailRouter.createModule(withUser: user))
    }
}
