//
//  TypeModel.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 2/18/25.
//

import Foundation
import SwiftData

@Model
class Types: Identifiable {
  var id: String
  var client: String
  var site: String
  var type: String
  var subType: String
  var subSubType: String
  var udf1: String
  
  init(id: String, client: String, site: String, type: String, subType: String, subSubType: String, udf1: String) {
    self.id = id
    self.client = client
    self.site = site
    self.type = type
    self.subType = subType
    self.subSubType = subSubType
    self.udf1 = udf1
  }
}
