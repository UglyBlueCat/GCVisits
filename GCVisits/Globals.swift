//
//  Globals.swift
//  GCVisits
//
//  Created by Robin Spinks on 05/03/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

// A place to define variables and functions that may be used throughout the project
// This improves flexibility for future configuration changes, such as using a live URL instead of a test URL

import Foundation

let userDefaults: UserDefaults = UserDefaults.standard
let apiURL = "http://somatest.ground-control.co.uk/SummerMaintService/"
let testParams = ["q":"dataRequest",
                  "token":"4C68F84A-CFE1-4245-B782-300D60438CB11",
                  "parentID":"",
                  "dataType":"1005",
                  "dateTime":"1900-01-01T00:00:00.000",
                  "latitude":"0.0",
                  "longitude":"0.0",
                  "radius":"0.0",
                  "rangeStart":"0",
                  "rangeEnd":"50"]

/**
 Prints a message to the console prefixed with filename, function & line number.
 A replacement for \_\_PRETTY_FUNCTION__
 
 - parameters:
 - msg: The message to print
 - function: The calling function or method (Defaults to #function)
 - file: The file containing function (Defaults to #file)
 - line: The line of the DLog call (Defaults to #line)
 */
func DLog(_ msg: String, function: String = #function, file: String = #file, line: Int = #line) {
    let url = URL(fileURLWithPath: file)
    let className:String = url.lastPathComponent
    print("[\(className) \(function)](\(line)) \(msg)")
}
