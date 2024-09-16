//
//  SwiftulCryptoApp.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/14/24.
//

import SwiftUI

@main
struct SwiftulCryptoApp: App {
    
    @StateObject private var viewModel = HomeViewModel()
    

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environmentObject(viewModel)
        }
    }
}
