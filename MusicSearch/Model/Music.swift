//
//  Music.swift
//  MusicSearch
//
//  Created by Soo Jang on 2022/12/01.
//

import UIKit

struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}

struct Music: Codable {
    let artistName, collectionName, trackName: String?
    let artworkUrl100: String?
    private let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case artistName, collectionName, trackName
        case artworkUrl100, releaseDate
    }
    
    var releaseDateString: String? {
        // 서버에서 주는 형태 (ISO규약에 따른 문자열 형태)
        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate ?? "") else {
            return ""
        }
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = myFormatter.string(from: isoDate)
        return dateString
    }
}
