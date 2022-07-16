//
//  ItunesDecode.swift
//  testITunes
//
//  Created by cmStudent on 2022/05/09.
//

import Foundation

struct ItunesRequest {
    let term: String
    let country: String
    let media: String
    
    init(term: String, country: String = "jp", media: String) {
        
        self.term = term
        self.country = country
        self.media = media
    }
}

struct ITunesSearchResult: Decodable {
    let results: [Result]
    
    struct Result: Decodable, Hashable {
        let trackCensoredName: String
        let formattedPrice: String
        let releaseDate: String
        let artistName: String
        let trackViewUrl: String
    }
}
