//
//  UIApplication.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/17/24.
//

import Foundation
import SwiftUI


extension UIApplication {
    
    /// Responsible for killing the keyboard when the `x` mark is selected in the keyboard
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
