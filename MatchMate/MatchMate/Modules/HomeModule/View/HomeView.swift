//
//  ContentView.swift
//  MatchMate
//
//  Created by Tushar Gupta on 26/08/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(presenter.users) { user in
                        CardView(user: user)
                            .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Profile Matches")
            .onAppear {
                presenter.viewDidLoad()
            }
        }
    }
}


#Preview {
    HomeRouter.createModule()
}
