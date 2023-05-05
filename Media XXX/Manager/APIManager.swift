//
//  APIManager.swift
//  Media XXX
//
//  Created by AbdoYosre on 9/2/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    class func loadMedia(term: String, media: String,completion: @escaping (_ error: Error?, _ Movies: [Media]?) -> Void) {
        // Media not Media Type as u made
        let param = [Params.media: media, Params.term: term]
        
        let url = "https://itunes.apple.com/search?"
        Alamofire.request(url, method: HTTPMethod.get, parameters: param, encoding: URLEncoding.default, headers: nil).response {
            response in
            
            guard response.error == nil else {
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from the server")
                return
            }
            do {
                let decoder = JSONDecoder()
                let mediaArr = try decoder.decode(MediaResponse.self, from: data).results
                completion(nil, mediaArr)
            } catch let error {
                print(error)
            }
        }
    }
}
