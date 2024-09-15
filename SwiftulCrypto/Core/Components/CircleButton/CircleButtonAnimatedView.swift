//
//  CircleButtonAnimatedView.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/14/24.
//

import SwiftUI

struct CircleButtonAnimatedView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/ : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? .easeOut(duration: 1.0) : .none, value: animate)
    }
}

#Preview {
    CircleButtonAnimatedView(animate: .constant(true) )
        .previewLayout(.fixed(width: 100, height: 100))
}
