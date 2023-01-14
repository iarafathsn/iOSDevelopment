//
//  Logger.swift
//  MyWallet
//
//  Created by Arafat Hossain on 14/1/23.
//

import Foundation

enum LogEvent: String {
   case e = "‼️" // error
   case i = "ℹ️" // info
   case d = "💬" // debug
   case v = "🔬" // verbose
   case w = "⚠️" // warning
   case s = "🔥" // severe
}

class Logger {
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    class func i(_ object: Any,
           fileName: String = #file,
           line: Int = #line,
           column: Int = #column,
           funcName: String = #function) {
        
        print("\(LogEvent.i.rawValue) \(Date().toString()) [\(sourceFileName(filePath: fileName))] : [\(line), \(column)] \(funcName) -> \(object)")
    }
    
    class func e(_ object: Any,
           fileName: String = #file,
           line: Int = #line,
           column: Int = #column,
           funcName: String = #function) {
        
        print("\(LogEvent.e.rawValue) \(Date().toString()) [\(sourceFileName(filePath: fileName))] : [\(line), \(column)] \(funcName) -> \(object)")
    }
    
    class func d(_ object: Any,
           fileName: String = #file,
           line: Int = #line,
           column: Int = #column,
           funcName: String = #function) {
        
        print("\(LogEvent.d.rawValue) \(Date().toString()) [\(sourceFileName(filePath: fileName))] : [\(line), \(column)] \(funcName) -> \(object)")
    }
    
    class func v(_ object: Any,
           fileName: String = #file,
           line: Int = #line,
           column: Int = #column,
           funcName: String = #function) {
        
        print("\(LogEvent.v.rawValue) \(Date().toString()) [\(sourceFileName(filePath: fileName))] : [\(line), \(column)] \(funcName) -> \(object)")
    }
    
    class func w(_ object: Any,
           fileName: String = #file,
           line: Int = #line,
           column: Int = #column,
           funcName: String = #function) {
        
        print("\(LogEvent.w.rawValue) \(Date().toString()) [\(sourceFileName(filePath: fileName))] : [\(line), \(column)] \(funcName) -> \(object)")
    }
    
    class func s(_ object: Any,
           fileName: String = #file,
           line: Int = #line,
           column: Int = #column,
           funcName: String = #function) {
        
        print("\(LogEvent.s.rawValue) \(Date().toString()) [\(sourceFileName(filePath: fileName))] : [\(line), \(column)] \(funcName) -> \(object)")
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}
