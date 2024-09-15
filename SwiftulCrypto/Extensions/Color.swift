//
//  Color.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/14/24.
//

import Foundation
import SwiftUI

/// By extending the color class we can reference our colors
/// using this static data member. 
extension Color {

    static let theme = ColorTheme()
}

/// A class that references the custom colors
struct ColorTheme {

    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondTextColor")
}
