//
//  DateFormatter.swift
//  JournalCloudKit35
//
//  Created by Colton Swapp on 8/17/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import Foundation

extension Date {
    
    func dateAsString() -> String {
        
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        
        return df.string(from: self)
    }
    
}
