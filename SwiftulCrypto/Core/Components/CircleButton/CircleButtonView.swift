//
//  CircleButtonView.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/14/24.
//

import SwiftUI

/// The `CircleButtonView` is a reusable component
/// for creating buttons for navigation bar. 
struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25),
                    radius: 10, x: 0, y: 0)
            .padding()
    }
}

#Preview {
    Group {
        CircleButtonView(iconName: "info")
            .previewLayout(.sizeThatFits)
    }
   
}
