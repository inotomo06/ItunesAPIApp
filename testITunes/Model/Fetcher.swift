//
//  Fetcher.swift
//  testITunes
//
//  Created by cmStudent on 2022/05/09.
//

import Foundation

class Fetcher {

    enum FetchError: Error {
        case clientError(Error)
        case networkError
        case statusError
    }

    static func fetch(from url: URL, session: URLSession? = nil) async -> Result<Data, Error> {

        // リクエストを作成してfetch()にやってもらう
        let request = URLRequest(url: url)
        return await self.fetch(from: request, session: session)
    }

    static func fetch(from request: URLRequest, session: URLSession? = nil) async -> Result<Data, Error> {
        let session = (session == nil) ? URLSession(configuration: .default) : session!

        do {
            // awaitを使う 非同期で実行中
            let (data, response) = try await session.data(for: request)

            guard let response = response as? HTTPURLResponse else {
                return .failure(FetchError.networkError)
            }

            if !(200...299).contains(response.statusCode) {
                print("ステータスコードが正常じゃないよ： \(response.statusCode)")
                return .failure(FetchError.statusError)
            }

            return .success(data)
        } catch(let error) {
            return .failure(error)
        }
    }
}

