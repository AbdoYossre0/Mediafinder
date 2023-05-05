//
//  SQliteManager.swift
//  Media XXX
//
//  Created by AbdoYosre on 9/16/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import Foundation
import SQLite

class SQliteManager {
    
    private static let sharedInstance = SQliteManager()
    
    class func shared() -> SQliteManager {
        return SQliteManager.sharedInstance
    }
    
    var database: Connection!
    
    let researchresults = Table("results")
    let name = Expression<String>("nameLabel")
    let descrption = Expression<String>("longDescrptionLabel")
    let imageview = Expression<String>("artWorkImageView")
   
    func setupConnection() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("results").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    
    func creteMediaTable() {
        print("CreateTable")
        let createTable = self.researchresults.create { (table) in
            table.column(self.name)
            table.column(self.descrption)
            table.column(self.imageview)
        }
        do {
            try self.database.run(createTable)
            print("CreatedTable")
        } catch {
            print(error)
        }
    }
    
    
    func insertNewMedia() {
        let insertMedia = self.researchresults.insert(self.name <- name, self.descrption <- descrption, self.imageview <- imageview)
        do {
            try self.database.run(insertMedia)
            print("insert Media")
        } catch {
            print(error)
        }
    }
    
    func listOfMedia() {
        print("LIST Of Media")
        
        do {
            let results = try self.database.prepare(self.researchresults)
            for result in results {
                print("name: \(result[self.name]),descrption: \(result[self.descrption]), imageview: \(result[self.imageview])")
            }
        } catch {
            print(error)
        }
    }
    
    
    
}
    
    
    

