//
//  regex.swift
//  Media XXX
//
//  Created by abdoyossre on 8/18/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func isValidPassword(password:String?) -> Bool {
        
        guard password != nil else { return false }
        let regEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: password)
    }
}

