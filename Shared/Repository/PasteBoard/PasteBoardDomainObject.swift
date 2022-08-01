//
//  PasteBoardDomainObject.swift
//  RealtimePasteBoard (iOS)
//
//  Created by Book on 2022/7/30.
//

import Foundation

struct PasteBoardDomainObject {
    struct PasteData:Identifiable {
        
        var title:String
        var value:String
        
        var id:String {
            UUID().uuidString
        }
    }
}
