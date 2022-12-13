//
//  NameSpace.swift
//  MusicSearch
//
//  Created by Soo Jang on 2022/12/01.
//

import Foundation


public struct MusicApi {
    // itunse api
    static let requestUrl: String = "https://itunes.apple.com/search?"
    static let mediaParam: String = "media=music"
    
    private init() {}
}

public struct Cell {
    static let musicCellIdentifier = "MusicCell"
    static let musicCollectionViewCellIdentifier = "MusicCollectionViewCell"
    private init() {}
}

public struct CellSize {
    static let cellHeight: CGFloat = 100

    private init() {}
}

public struct CVCell {
    static let spacingWitdh: CGFloat = 1
    static let cellColumns: CGFloat = 3
    private init() {}
}


