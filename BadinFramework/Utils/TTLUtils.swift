//
//  TTLUtils.swift
//  genericappios
//
//  Created by DC on 06/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import UIKit

open class TTLUtils {
    
    open  static let baseURL = "https://transactortech.co.nz/TransactorAPI/api/2/"
    
    open static func  getDate(dateIn : String) -> String {
        
        if (dateIn != "")
        {
            
            let dateFormatter = DateFormatter()
            var date = Date()
            
            let newString = dateIn.replacingOccurrences(of: "T", with: " ", options: .literal, range: nil)
            let newString1 = newString.replacingOccurrences(of: "Z", with: "", options: .literal, range: nil)
            
            
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            date = dateFormatter.date(from: newString1)!
            
            
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            return dateFormatter.string(from: date)
            
        }
        else
        {
            return ""
        }
    }
    open static func getToday() -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let date : Date! = Date()
        return  formatter1.string(from: date)+"Z"
        
    }
    
    
    open static func getFutureToday() -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let date = Calendar.current.date(byAdding: .year, value: 100, to: Date())
        return  formatter1.string(from: date!)+"Z"
        
    }
    
    
    open static func  getDate(dateIn : String) -> Date {
        
        
        
        let dateFormatter = DateFormatter()
        var date = Date()
        
        let newString = dateIn.replacingOccurrences(of: "T", with: " ", options: .literal, range: nil)
        let newString1 = newString.replacingOccurrences(of: "Z", with: "", options: .literal, range: nil)
        
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date = dateFormatter.date(from: newString1)!
        
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return date
        
    }
    
    open static func getNavBarY() -> Int {
        if  UIScreen.main.nativeBounds.height > 2500
        {
            return 50;
        }
        else
            if  UIScreen.main.nativeBounds.height > 00
            {
                return 30;
            }
            else
        {
            return 30
        }
       
    }
}

extension Date {
    
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.timeIntervalSince1970 < self.timeIntervalSince1970 && date2.timeIntervalSince1970 > self.timeIntervalSince1970
    }
    
    func isLess(date date1:Date) -> Bool {
     return date1.timeIntervalSince1970 > self.timeIntervalSince1970
    }
    
}

