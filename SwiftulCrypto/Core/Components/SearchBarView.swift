//
//  SearchBarView.swift
//  SwiftulCrypto
//
//  Created by Armaghan Asghar on 9/15/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchBarText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.theme.accent)
            TextField("Search by name or symbol...", text: $searchBarText)
                .foregroundStyle(Color.theme.accent)
                .keyboardType(.default)
                .autocorrectionDisabled(true)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.theme.accent)
                        .padding()
                        .offset(x: 15)
                        .opacity(searchBarText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchBarText = ""
                            UIApplication.shared.endEditing()
                        }
                        
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15),
                        radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        )
        .padding()
    }
}

#Preview("Light These") {
    SearchBarView(searchBarText: .constant(""))
}

#Preview("Dark Theme") {
    SearchBarView(searchBarText: .constant(""))
        .preferredColorScheme(.dark)
}

