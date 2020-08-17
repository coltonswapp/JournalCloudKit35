//
//  EntryController.swift
//  JournalCloudKit35
//
//  Created by Colton Swapp on 8/17/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    // MARK: - SharedInstance
    static let sharedInstance = EntryController()
    
    let privateDB = CKContainer.default().publicCloudDatabase
    // MARK: - Source of Truth
    var entries: [Entry] = []
    
    
    // MARK: - Crud funcs
    
    func createEntry(with title: String, body: String, completion: @escaping (_ result: Result<Entry?, EntryError>) -> Void) {
        
        let newEntry = Entry(title: title, body: body)
        saveEntry(save: newEntry, completion: completion)

    }
    
    func saveEntry(save entry: Entry, completion: @escaping (Result<Entry?, EntryError>) -> Void) {
        
        let entryToSave = entry
        let entryRecord = CKRecord(entry: entryToSave)
        
        privateDB.save(entryRecord) { (record, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record,
                let savedEntry = Entry(ckRecord: record)
                else { return completion(.failure(.couldNotUnwrap))}
            
            self.entries.insert(savedEntry, at: 0)
            
            print("Entry was saved successfully.")
            completion(.success(savedEntry))
        }
    }
    
    func fetchEntriesWith(completion: @escaping (Result<[Entry]?, EntryError>) -> Void ) {
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: EntryStrings.recordTypeKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let records = records else { return completion(.failure(.couldNotUnwrap)) }
            
            print("All entries were retrieved successfully.")
            
            let entries = records.compactMap({ Entry(ckRecord: $0) })
            
            completion(.success(entries))
            
        }
        
    }
    
}
