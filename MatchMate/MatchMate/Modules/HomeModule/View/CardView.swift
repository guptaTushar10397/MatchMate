//
//  CardView.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import SwiftUI

struct CardView: View {
    let user: User
    let didTapAcceptButton: () -> Void
    let didTaponRejectButton: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.white)
                .shadow(radius: 10)
            
            VStack(spacing: 25) {
                
                VStack(spacing: 20) {
                    
                    AsyncImage(url: URL(string: user.picture?.large ?? "")) { phase in
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
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    
                    VStack(spacing: 10) {
                        Text(user.name?.fullName ?? "")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.teal)
                        
                        Text(user.location?.address ?? "")
                            .font(.callout)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.gray)
                    }
                }
                
                if let userAction = user.userAction {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.teal)
                        .overlay {
                            Text(userAction.displayValue)
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                        .frame(height: 60)
                        .padding(.horizontal)
                } else {
                    HStack(spacing: 40) {
                        Button {
                            didTaponRejectButton()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 24))
                                .foregroundColor(.red)
                                .padding()
                                .background(Circle().fill(Color.white))
                                .shadow(radius: 5)
                        }
                        
                        Button {
                            didTapAcceptButton()
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
            }
        }
        .frame(height: 320)
    }
}

#Preview {
    CardView(user: .mockUserAccepted,
             didTapAcceptButton: { },
             didTaponRejectButton: { })
}
