//
//  ContentView.swift
//  testITunes
//
//  Created by cmStudent on 2022/05/09.
//

import SwiftUI

struct ContentView: View {
    // サブメニューのやつ
    @State var isOpenSideMenu = false
    // textfieldのやつ
    @State private var bookName = ""
    // 検索をかけたら遷移するやつ
    @State private var isLink = false
    
    var body: some View {
        
        ZStack {
            NavigationView {
                VStack {
                    TextField("タイトルを入力してくだい", text: $bookName, onCommit: { // 検索用のtextfield
                        print(bookName)
                        isLink.toggle()
                    })
                        .keyboardType(.webSearch)
                        .padding()
                        .navigationBarItems(leading: (  // サブメニュー用
                            Button {
                                isOpenSideMenu.toggle()
                                
                            } label: {
                                Image(systemName: "line.horizontal.3")
                                    .imageScale(.large)
                            }))
                    // 検索結果のファイルに遷移
                    NavigationLink(destination: BookListView(bookName: $bookName), isActive: $isLink) {
                        EmptyView()
                    }
                    .navigationTitle(bookName)
                    
                    Spacer()
                }
            }
            SideMenuView(isOpen: $isOpenSideMenu, bookName: $bookName)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
