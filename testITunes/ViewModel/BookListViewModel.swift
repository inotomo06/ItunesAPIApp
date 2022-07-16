//
//  ItunesViewModel.swift
//  testITunes
//
//  Created by cmStudent on 2022/05/09.
//

import Foundation

@MainActor
class BookListViewModel: ObservableObject {
    
    /// ステータス管理用のenum
    enum RequestStatus {
        case unexecuted // 未実行
        case success    // 成功
        case failed     // 失敗
    }
    
    // JSONの受け取りオブジェクト
    var iTunesSearchResult: ITunesSearchResult!
    
    @Published var status: RequestStatus
    // インジケータ
    @Published var loading = true
    
    @Published var iTunesUrl = ""
    @Published var isShowSafari = false
    
    init() throws {
        // 初期化
        iTunesSearchResult = nil
        status = .unexecuted
    }
    
    func settings(title: String) throws {
        
        // URLが正しくなかったらエラー
        guard let url = URL(string: URLConst.END_POINT) else {
            throw NSError()
        }
        // コンポーネントが作られなかったらエラー
        guard var component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NSError()
        }
        // パラメータの設定
        let request = ItunesRequest(term: title, media: URLConst.ENTITY)
        
        let mirror = Mirror(reflecting: request)
        
        var queryItems: [URLQueryItem] = []
        
        for child in mirror.children {
            if let label = child.label,
               let value = child.value as? String {
                queryItems.append(.init(name: label, value: value))
            } else {
                continue
            }
        }
        
        component.queryItems = queryItems
        
        // コンポーネントからURLが作成できなかったらエラー
        guard let componentURL = component.url else {
            throw NSError()
        }
        
        Task {
            // Modelに処理をしてもらう
            let result = await Fetcher.fetch(from: componentURL)
            switch result {
            case .failure(let error):
                print(error)
                status = .failed
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(ITunesSearchResult.self, from: data)
                    iTunesSearchResult = result
                    // 正常に実行されていたらステータス変更
                    status = .success
                    loading = false
                } catch {
                    // 失敗したら失敗のステータスに変更
                    status = .failed
                }
            }
        }
    }
    
    func urlString(url: String) {
        iTunesUrl = url
    }
}
