//
//  DetailView.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import SwiftUI

struct DetailView: View {
    @StateObject var presenter: DetailPresenter
    
    var body: some View {
        Text(presenter.user?.name?.fullName ?? "")
            .onAppear {
                presenter.viewDidLoad()
            }
    }
}

#Preview {
    DetailRouter.createModule(withUser: User.mockUser)
}
