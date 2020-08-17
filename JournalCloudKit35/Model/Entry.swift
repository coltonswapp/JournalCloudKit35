//
//  Entry.swift
//  JournalCloudKit35
//
//  Created by Colton Swapp on 8/17/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import Foundation
import CloudKit

struct EntryStrings {
    static let recordTypeKey = "Entry"
    static let bodyKey = "body"
    static let titleKey = "title"
    static let timestampKey = "timestamp"
}

class Entry {
    
    var title: String
    var body: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.body = body
        self.title = title
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
    
} // End of class

// MARK: - Extensions

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryStrings.recordTypeKey, recordID : entry.ckRecordID)
        self.setValuesForKeys([
            EntryStrings.titleKey : entry.title,
            EntryStrings.bodyKey : entry.body,
            EntryStrings.timestampKey : entry.timestamp
        ])
    }
} // End of extension

extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryStrings.titleKey] as? String,
            let body = ckRecord[EntryStrings.bodyKey] as? String,
            let timestamp = ckRecord[EntryStrings.timestampKey] as? Date
            else { return nil }
        
        self.init(title: title, body: body, timestamp: timestamp)
    }
}
