//
//  a.swift
//  testITunes
//
//  Created by cmStudent on 2022/05/09.
//

import SwiftUI

struct RegistrationView: View {
    // ひとつ前のviewに戻るよう
    @Environment(\.presentationMode) var presentation
    // 検索履歴用
    @Binding var binText: String
    // 履歴をためておく配列
    @State private var searchHistory: [String] = []
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button {
                    // ひとつ前のView戻る
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("戻る")
                }
                Spacer()
                Text("検索履歴")
                    .padding()
                Spacer()
                
                Button {
                    // searchHistoryに保存してある配列の情報を入れる
                    searchHistory = UserDefaults.standard.array(forKey: "key") as! [String]
                    
                    print("binText:" + binText)
                    
                    if binText != "" { // 検索データが空ではなかったら(同じのが複数記録されるのを防ぐ)
                        // searchHistory配列に検索した履歴を追加
                        searchHistory.append(binText)
                        print(searchHistory[0])
                        // 配列データを保存
                        UserDefaults.standard.set(searchHistory, forKey: "key")
                    }
                    // 何度も追加されないように空文字に
                    binText = ""
                    
                } label: {
                    Text("表示")
                }
                Spacer()
            }
            
            List() { // 履歴をList形式で表示
                ForEach(searchHistory, id: \.self) { books in
                    Text(books)
                }
            }
            Spacer()
        }
    }
}
