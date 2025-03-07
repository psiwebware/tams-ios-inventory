//
//  DataItem.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 1/22/25.
//

import Foundation
import SwiftData

@Model
class DataItem: Identifiable {
  var id: String
  var name: String
  
  init(id: String, name: String) {
    self.id = UUID().uuidString
    self.name = name
  }
}
