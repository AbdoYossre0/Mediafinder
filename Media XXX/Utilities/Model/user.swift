//
//  user.swift
//  Media XXX
//
//  Created by abdoyossre on 8/18/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import UIKit

enum Gender: String, Codable {
    case mail, femail
}

struct User : Codable {
    var name: String!
    var email: String!
    var image: CodableImage!
    var password: String!
    var address: String!
    var gender: Gender!
    var phoneNum: String!
}



struct CodableImage: Codable {
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 1.0)
    }
    
    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        return image
    }
}

