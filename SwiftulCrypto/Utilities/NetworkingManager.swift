//
//  NetworkingManager.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/15/24.
//

import Foundation
import Combine

/// A reusable class for downloading the data from the internet. 
class NetworkingManager {
    
    /// Erros specific to my application
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad response from URL \(url)"
            default:
                return "[⚠️] Unknown error occured"
            }
        }
    }
    
    /// Function to download any data that is fetched from a remote url.
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher() // Erasing strong type, I guess.
    }
    
    
    /// To handle the URL response and process the data accordingly.
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url) // bespoke error returned.
        }
        return output.data
    }
    
    /// To be called after decoding the data to make sure if there were any errors then those
    /// are caught. 
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

