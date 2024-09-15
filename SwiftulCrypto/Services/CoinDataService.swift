//
//  CoinDataService.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/15/24.
//

import Foundation
import Combine

/// This class is responsible for downloading the JSON data off the server.
class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    init() {
      getAllCoins()
    }
    
    private func getAllCoins() {
        
        guard let url = URL(string:
            "https://api.coingecko.com/api/v3/coins/markets?order=market_cap_desc&page=1&sparkline=true&price_change_percentage=24&vs_currency=usd"
        ) else {
            return
        }
        
        /**
         (1) Assign to the background thread to process this URL Request, and recieve on main thead. 
         (2) Check to see if the HTTP response is valid
         (3) Decode the HTTP response into a defined structure model
         (4) Check if there was an error parsing/decoding the values
         (5) When sucessfully received everything then assign to the array. 
         */
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
           
            .sink(receiveCompletion:  NetworkingManager.handleCompletion) { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
        
    }
    
}
