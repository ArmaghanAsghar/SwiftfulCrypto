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
         (1) Assign the main thread to process this URL Request
         (2) Check to see if the HTTP response is valid
         (3) Decode the HTTP response into a defined structure model
         (4) Check if there was an error parsing/decoding the values
         (5) When sucessfully received everything then assign to the array. 
         */
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            } receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
        
    }
    
}
