//
//  HomeView.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/14/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                HomeViewHeader
                Spacer()
            }
        }
    }
}


extension HomeView {
    
    private var HomeViewHeader: some View {
        
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info" )
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimatedView(animate: $showPortfolio)
                )
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(showPortfolio ? .degrees(180) : .zero)
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    
    
    
}
