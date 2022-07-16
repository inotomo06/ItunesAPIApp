
//  SideMenuContentView.swift
//  testITunes
//
//  Created by cmStudent on 2022/05/09.


import SwiftUI

struct SideMenuContentView: View {
    let topPadding: CGFloat
    let text: String
//    @Binding var bindText: String
    @Binding var isOpen: Bool
    
    @State private var isSheet = false
    
    init(topPadding: CGFloat = 30, text: String, isOpen: Binding<Bool>) {
        self.topPadding = topPadding
//        _bindText = bindText
        _isOpen = isOpen
        self.text = text
    }
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.gray)
                .font(.headline)
            Spacer()
        }
        .padding(.top, topPadding)
        .padding(.leading, 32)
        .onTapGesture {
            isSheet.toggle()
        }.fullScreenCover(isPresented: $isSheet) { // 検索履歴のViewに遷移
            RegistrationView()
        }
    }
}

