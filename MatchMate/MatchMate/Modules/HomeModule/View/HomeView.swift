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
            ZStack {
                if presenter.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(presenter.users) { user in
                                NavigationLink {
                                    presenter.navigateToDetail(for: user)
                                } label: {
                                    CardView(user: user,
                                             didTapAcceptButton: { presenter.handleAcceptAction(for: user) },
                                             didTaponRejectButton: { presenter.handleRejectAction(for: user) }
                                    )
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.vertical)
                        }
                    }
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
