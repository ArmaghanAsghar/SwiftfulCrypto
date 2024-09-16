//
//  CoinImageView.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/15/24.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel) {
        // Not sure why I need an underscore while initializing the @StateObject
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit() // Takes share of parent container.
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview("Light Theme") {
    CoinImageView(coin: GlobalSampleModel.inst.coinModelSample)
        .previewLayout(.sizeThatFits)
}

#Preview("Dark Theme") {
    CoinImageView(coin: GlobalSampleModel.inst.coinModelSample)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
}

