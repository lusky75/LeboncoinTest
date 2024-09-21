//
//  Log.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

/**
 Simple Logger class
 */
struct Log {
    /// Prints in debug only
    static func debug(_ msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function, tag: String = "DEBUG") {
        #if DEBUG
        let fname = (fileName as NSString).lastPathComponent
        let dateToPrint = DateFormatter.loggerDateFormatter.string(from: Date())
        print("[\(tag)][\(fname) \(funcName):\(line)][\(dateToPrint)]", msg)
        #endif
    }
    
    /// Prints an error message in debug only
    static func error(_ msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function) {
        debug(msg, line: line, fileName: fileName, funcName: funcName, tag: "ERROR")
    }
    
    /// Prints the debug mark for the line
    static func mark(line: Int = #line, fileName: String = #file, funcName: String = #function) {
        debug("************************************", line: line, fileName: fileName, funcName: funcName)
    }
    
    /// pretty print
    static func pretty(_ msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function) {
        #if DEBUG
        let fname = (fileName as NSString).lastPathComponent
        let dateToPrint = DateFormatter.loggerDateFormatter.string(from: Date())
        print("[\(fname) \(funcName):\(line)][\(dateToPrint)]")
        dump(msg)
        #endif
    }
}

fileprivate extension DateFormatter {
    static let loggerDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        return formatter
    }()
}
