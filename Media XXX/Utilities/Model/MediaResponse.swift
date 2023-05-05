//
//  MediaResponse.swift
//  Media XXX
//
//  Created by AbdoYosre on 9/9/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import Foundation


struct MediaResponse: Codable {
    
    var resultCount: Int
    var results: [Media]
    
}
