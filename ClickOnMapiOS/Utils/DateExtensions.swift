//
//  DateExtension.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 24/11/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation

extension Date {
    
    func serverFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: self)
        
    }
    
    func appFormat(_ date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY HH:mm:ss"
        
        if let formattedDate =  dateFormatter.date(from: date) {
            return dateFormatter.string(from: formattedDate)
        }
        
        return date
        
    }
    
}
