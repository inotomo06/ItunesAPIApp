//
//  BookListView.swift
//  testITunes
//
//  Created by cmStudent on 2022/05/09.
//

import SwiftUI

struct BookListView: View {
    
    @ObservedObject private var bookListViewModel: BookListViewModel
    // ContentViewのbookName
    @Binding var bookName: String
    
    init(bookName: Binding<String>) {
        _bookName = bookName
        do {
            bookListViewModel = try BookListViewModel()
        } catch {
            fatalError("URL ERROR")
        }
    }
    
    var body: some View {
        
        VStack {
            // 成功したら
            if bookListViewModel.status == .success {
                List(bookListViewModel.iTunesSearchResult.results, id: \.self) { result in
                    VStack(alignment: .leading) {
                        Text(result.trackCensoredName)
                            .padding(.bottom)
                            .font(.headline)
                        Text(result.artistName)
                        Text(result.formattedPrice)
                    }
                }
                
            } else if bookListViewModel.status == .unexecuted {
                ProgressView("検索中です")
                    .foregroundColor(.blue)
                    .font(.system(size: 20))
            } else {
                Text("読み込みに失敗しました")
            }
        }
        .onAppear {
            try! bookListViewModel.settings(title: bookName)
        }
    }
}

