//
//  ContentView.swift
//  MatchMate
//
//  Created by Tushar Gupta on 26/08/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            CardView()
                .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}

struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.white)
                .shadow(radius: 10)
            
            VStack(spacing: 25) {
                
                VStack(spacing: 20) {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 80, height: 80)
                    
                    VStack(spacing: 10) {
                        Text("Tushar Gupta")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.teal)
                        
                        Text("Plot No GH-02/A, Sector 16, Vaidpura, Greater Noida, Ghaziabad, Uttar Pradesh 201309")
                            .font(.callout)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.gray)
                    }
                }
                
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
        }
        .frame(height: 320)
    }
}
