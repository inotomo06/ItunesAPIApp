//
//  SideMenuView.swift
//  testITunes
//
//  Created by cmStudent on 2022/05/09.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isOpen: Bool
    @Binding var bookName: String
    let width: CGFloat = 270
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(isOpen ? 1.0 : 0.0)
            .opacity(1.0)
            .animation(.easeIn(duration: 0.25))
            .onTapGesture {
                isOpen = false
            }
            
            HStack {
                VStack() {
                    SideMenuContentView(topPadding: 100, text: "検索履歴", bindText: $bookName, isOpen: $isOpen)
                    Spacer()
                }
                .frame(width: width)
                .background(Color(UIColor.systemGray6))
                .offset(x: isOpen ? 0 : -width)
                .animation(.easeIn(duration: 0.25))
                Spacer()
            }
        }
    }
}
