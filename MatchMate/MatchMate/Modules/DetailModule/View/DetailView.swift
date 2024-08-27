//
//  DetailView.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        VStack(spacing: 25) {
            AsyncImage(url: URL(string: presenter.user?.picture?.large ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "exclamationmark.icloud")
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    EmptyView()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .teal, radius: 20)
            
            VStack(spacing: 10) {
                Text(presenter.user?.name?.fullName ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.teal)
                
                Text(presenter.user?.location?.address ?? "")
                    .font(.callout)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
            }
            
            if let userAction = presenter.user?.userAction {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.teal)
                    .overlay {
                        Text(userAction.rawValue)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                    }
                    .frame(height: 80)
            } else {
                HStack(spacing: 40) {
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24))
                            .foregroundColor(.red)
                            .padding()
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 5)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 24))
                            .foregroundColor(.green)
                            .padding()
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 5)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            presenter.viewDidLoad()
        }
    }
}

#Preview {
    DetailRouter.createModule(withUser: User.mockUserRejected)
}
