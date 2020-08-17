//
//  EntryError.swift
//  JournalCloudKit35
//
//  Created by Colton Swapp on 8/17/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import Foundation

enum EntryError : LocalizedError {
    
    case ckError(Error)
    case couldNotUnwrap
    
    var errorDescription: String {
        switch self {
        case .ckError(let error):
            return error.localizedDescription
        case .couldNotUnwrap:
            return "Unable to fetch entry."
        }
    }
    
}
