//
//  DataHandler.swift
//  GCVisits
//
//  Created by Robin Spinks on 05/03/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

import Foundation

class DataHandler {
    
    init() {}
    
    /**
     Converts a raw data object to JSON, which is then passed to populateResults
     
     - parameter newData: The raw data
     */
    func newData (newData: Data) {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: newData, options: .mutableLeaves)
            self.populateResults(jsonData: jsonData as AnyObject)
        } catch {
            DLog("JSON conversion error: \(error)")
        }
    }
    
    /**
     Parses a JSON object.
     
     - parameter jsonData: The JSON object
     */
    func populateResults (jsonData: AnyObject) {
        if let resultData = jsonData as? NSDictionary {
            if let error = resultData["error"] as? String {
                DLog("error: \(error)")
            } else {
                if let recordData = resultData["data"] as? NSDictionary {
                    if let records = recordData["records"] as? NSArray {
                        self.storeVisits(visitArray: records)
                    }
                }
            }
        } else {
            DLog("Cannot convert data")
        }
    }
    
    /**
     Stores visit data into the DB
     
     - parameter visitArray: The visit data
     */
    func storeVisits (visitArray : NSArray) {
        for i in 0..<visitArray.count {
            if let visit = visitArray[i] as? NSDictionary {
                if let visitNumber = visit["visitNumber"] as? Int,
                    let siteId = visit["siteId"] as? String,
                    let client = visit["client"] as? String,
                    let site = visit["site"] as? String {
                    DB_Interface.sharedInstance.addVisit(theVisitNumber: visitNumber, theSiteId: siteId, theClient: client, theSite: site)
                } else {
                    DLog("Cannot extract data fields from visitArray[\(i)]")
                }
            } else {
                DLog("Cannot convert visitArray[\(i)]")
            }
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "kDataLoaded"), object: nil)
    }
}
