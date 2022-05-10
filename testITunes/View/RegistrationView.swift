//
//  a.swift
//  testITunes
//
//  Created by cmStudent on 2022/05/09.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentation
    
    @StateObject private var userDefaultViewModel = UserDefaultsViewModel()
    
    @Binding var binText: String
    
    @State private var searchHistory: [String] = []
    
    var body: some View {
        
        VStack {
            HStack {
                
                Spacer()
                
                Button {
                    //                    searchHistory = UserDefaults.standard.array(forKey: "key") as! [String]
                    self.presentation.wrappedValue.dismiss()
                    //                    UserDefaults.standard.set(searchHistory, forKey: "key")
                } label: {
                    Text("戻る")
                }
                
                Spacer()
                Text("検索履歴")
                    .padding()
                Spacer()
                
                Button {
                    print("binText:" + binText)
                    if binText != "" {
                        searchHistory.append(binText)
                        print(searchHistory[0])
                    }
                    binText = ""
                    UserDefaults.standard.set(searchHistory, forKey: "key")
                    
                } label: {
                    Text("表示")
                }
                
                Spacer()
            }
            
            List(0..<searchHistory.count) { i in
                Text(self.searchHistory[i])
                
//                ForEach(0..<searchHistory.count) { i in
//                    Text(self.searchHistory[i])
//
//                }
            }
            
            Spacer()
        }
    }
}
