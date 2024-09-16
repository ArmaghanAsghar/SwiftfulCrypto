//
//  LocalFileManager.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/15/24.
//

import Foundation
import SwiftUI

/// Class is responsible for storing the images  on disk, so we don't
/// retrieve them all the time as part of our server queries.
class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() {}
    
    /// Called to save an image in png format with `imageName` and the destination of `folderName`
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // (1) Create folder if does not exist.
        createFolder(folderName: folderName)
        
        // (2) Convert the image to .png format
        // (3) Get the path to which we want to save the image.
        guard
            let data = image.pngData(),
            let urlDestination = getURLForImage(imageName: imageName, folderName: folderName)
        else {
            return
        }
        
        // (4) Write the image to the destination which is a file on the filemanager.
        do {
            try data.write(to: urlDestination)
        } catch let error { // Common way of capture the wildcard
            print("Error saving image. ImageName: \(imageName) \(error)")
        }
        
    }
    
    
    /// Function to get the `UIImage` given the    `ImageName` and the `folderName`
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path(percentEncoded: true))
        else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path(percentEncoded: true))
    }
    
    
    /// Create a folder at the url path if it does not exist.
    private func createFolder(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName)
        else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path()) {
            
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory. FolderName: \(folderName). \(error)")
            }
            
        }
        
    }
    
    /// Function to get the URL for the folder at which we want to store the images
    /// in a cache environment. We would reference the `FileManager` singleton
    /// and store in the discardable cache files.
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else {
            return nil
        }
        return url.appendingPathComponent(folderName)
//        return url.appending(path: folderName)
    }
    
    /// Given the `imageName` amd  `folderName` find the path to which we
    /// can store the image to be reused later from that path.
    /// (1) We get the foldername at which we want to store the value
    /// (2) We append the image to the path
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let urlDestination = getURLForFolder(folderName: folderName)
        else {
            return nil
        }
//        return return url.appending(path: imageName + ".png")
        return urlDestination.appendingPathComponent(imageName + ".png")
    }
    
}
