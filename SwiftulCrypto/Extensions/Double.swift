//
//  Double.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/14/24.
//

import Foundation


extension Double {
    
    
    /// Converts a double into a currency with 2 decimal places
    ///  ```
    /// Convert 1234.56 to $1,234.56
    ///  ```
    private var currencyFormatter2: NumberFormatter {
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency // Default value
        formatter.locale = .current
        formatter.currencyCode = "usd" // Currency
        formatter.currencySymbol = "$" // Currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Converts a double into a currency with 2 to 6 decimal places
    ///  ```
    /// Convert 1234.56 to $1,234.56
    ///  ```
    private var currencyFormatter6: NumberFormatter {
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency // Default value
        formatter.locale = .current
        formatter.currencyCode = "usd" // Currency
        formatter.currencySymbol = "$" // Currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Converts a double into a currency a string with 2  decimal places
    ///  ```
    /// Convert 1234.56 to "$1,234.56"
    ///  ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Converts a double into a currency a string with 2 to 6 decimal places
    ///  ```
    /// Convert 1234.56 to "$1,234.56"
    ///  ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Converts a double into a string with 2 decimal precision
    ///  ```
    /// Convert 12.3456 to "12.34"
    ///  ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a double into a string with 2 decimal precision
    /// with % suffix
    ///  ```
    /// Convert 12.3456 to "12.34%"
    ///  ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
}
