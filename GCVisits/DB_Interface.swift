//
//  DB_Interface.swift
//  GCVisits
//
//  Created by Robin Spinks on 08/03/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

import Foundation
import SQLite

class DB_Interface {
    
    let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!
    let database : Connection
    let visits = Table("visits")
    let visitNumber = Expression<Int>("visitNumber")
    let siteId = Expression<String>("siteId")
    let client = Expression<String>("client")
    let site = Expression<String>("site")
    
    static let sharedInstance = DB_Interface()
    fileprivate init() {
        self.database = try! Connection("\(path)/db.sqlite3") // possible crash
        self.createVisitTable()
    }
    
    /**
     Creates a table in the database for containing visit data
     */
    private func createVisitTable() {
        
        do {
            try database.run(visits.create { table in
                table.column(visitNumber, primaryKey: true)
                table.column(siteId)
                table.column(client)
                table.column(site)
            })
        } catch {
            DLog("Unable to create visits table. Error: \(error)")
        }
    }
    
    /**
     Adds a visit to the visits table
     
     - parameters:
        - theVisitNumber:   The number of the visit
        - theSiteId:        The ID of the site
        - theClient:        The name of the client
        - theSite:          The name of the site
     */
    func addVisit(theVisitNumber : Int,
                  theSiteId : String,
                  theClient : String,
                  theSite : String) {
        
        let insert = visits.insert(visitNumber <- theVisitNumber, siteId <- theSiteId, client <- theClient, site <- theSite)
        
        do {
            _ = try database.run(insert)
        } catch {
            DLog("Cannot insert visit number \(theVisitNumber). Error: \(error)")
        }
    }
    
    /**
     Extracts all data from the visits table
     
     - returns: An NSArray of NSDictionaries, each containing data for one visit
     */
    func allVisits() -> NSArray {
        let allVisits : NSMutableArray = NSMutableArray()
        do {
            for visit in try database.prepare(visits) {
                let visitDictionary : NSDictionary = ["visitNumber":visit[visitNumber],
                                                      "siteId":visit[siteId],
                                                      "client":visit[client],
                                                      "site":visit[site]]
                allVisits.add(visitDictionary)
            }
        } catch {
            DLog("Could not extract data from visits. Error: \(error)")
        }
        return allVisits
    }
}
