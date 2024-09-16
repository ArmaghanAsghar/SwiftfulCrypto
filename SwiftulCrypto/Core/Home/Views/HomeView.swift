//
//  HomeView.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/14/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                
                HomeViewHeader
                columnTitles
                
                if !showPortfolio {
                    allCoinList
                    .transition(.move(edge: .leading))
                }
                else if showPortfolio {
                    portfolioCoinsList
                    .transition(.move(edge: .trailing))
                }
                
                
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
    
    
    private var allCoinList: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10,
                                         leading: 0,
                                         bottom: 10,
                                         trailing: 0)
                    )
            }
            
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10,
                                         leading: 0,
                                         bottom: 10,
                                         trailing: 0)
                    )
            }
            
        }
        .listStyle(.plain)
    }
    
    
    private var columnTitles: some View {
        HStack(alignment:.top) {
            Text("Coin")
            Spacer()
            
            if showPortfolio {
                Text("Holdings")
            }
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width/3.5)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.leading)
        .padding(.trailing, -10)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(HomeViewModel())
}

#Preview {
    NavigationStack {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(HomeViewModel())
    }
}
