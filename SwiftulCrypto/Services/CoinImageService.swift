//
//  CoinImageService.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/15/24.
//

import Foundation
import SwiftUI
import Combine

// A utility to fetch the data from the third-party
class CoinImageService {
 
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private var coin: CoinModel
    private var imageName: String
    private let fileManager = LocalFileManager.instance
    private let folderName: String = "coin_images"
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        // check if the image is in cache
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            self.image = savedImage
            print("Image was fetched from file")
        } else {
            downloadCoinImage()
            print("Image was fetched from web")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        /**
         (1) Assign to the background thread to process this URL Request, and recieve on main thead.
         (2) Try to download the image from the given URL and them return that.
         (3) The sink method would be the subscriber for this.
         */
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
           .sink(receiveCompletion:  NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
               
               guard let self = self, let downloadedImage = returnedImage else { return }
               self.image = downloadedImage
               self.imageSubscription?.cancel()
               self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
