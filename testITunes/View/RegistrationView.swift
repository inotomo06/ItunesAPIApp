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
    // 履歴をためておく配列
    @State private var recordArray: [String] = []
    
    var body: some View {
        
        VStack {
            ZStack {
                HStack {
                    Button {
                        // ひとつ前のView戻る
                        self.presentation.wrappedValue.dismiss()
                    } label: {
                        Text("戻る")
                    }
                    Spacer()
                }
                .padding(.leading)
                Text("検索履歴")
                    .padding(.top)
            }
        }
        
        List() {
            ForEach(recordArray, id: \.self) { books in
                Text(books)
            }
        }
        .refreshable{
            // recordArrayに保存してある配列の情報を入れる
            recordArray = UserDefaults.standard.array(forKey: "key") as! [String]
        }
        Spacer()
    }
}
