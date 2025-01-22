//
//  Item.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 1/22/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
