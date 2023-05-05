//
//  Media.swift
//  Media XXX
//
//  Created by AbdoYosre on 9/9/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import Foundation


public enum MediaType: String {
    case movie = "music"
    case music = "movie"
    case tvShow = "tvShow"
}


struct Media: Codable {
    
    var artistName: String?
    var trackName: String?
    var artworkUrl100: String!
    var longDescription: String?
    var previewUrl: String!
    var kind: String?

    func getType() -> MediaType {
        switch self.kind {
        case "song":
            return MediaType.music
        case "feature-movie":
            return MediaType.movie
        case "tv-episode":
            return MediaType.tvShow
        default:
            return MediaType.music
        }
    }
}





