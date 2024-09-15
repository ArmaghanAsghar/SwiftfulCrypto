//
//  HomeViewModel.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/14/24.
//

import Foundation


class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init(allCoins: [CoinModel], portfolioCoins: [CoinModel]) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(GlobalSampleModel.inst.coinModelSample)
            self.portfolioCoins.append(GlobalSampleModel.inst.coinModelSample)
        }
      
    }
                              
    
}
