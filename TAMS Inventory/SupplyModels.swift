//
//  SupplyModels.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 2/18/25.
//

import Foundation
import SwiftData

@Model
class Supply: Identifiable {
  var id: String
  var client: String
  var site: String
  var systemType: String
  var autoKey: String
  var partId: String
  var type: String
  var subType: String
  var vendor: String
  var onHand: String
  
  init(id: String, client: String, site: String, systemType: String, autoKey: String, partId: String, type: String, subType: String, vendor: String, onHand: String) {
    self.id = id
    self.client = client
    self.site = site
    self.systemType = systemType
    self.autoKey = autoKey
    self.partId = partId
    self.type = type
    self.subType = subType
    self.vendor = vendor
    self.onHand = onHand
  }
}

@Model
class SupplyAdjust: Identifiable {
  var id: String
  var client: String
  var site: String
  var systemType: String
  var autoKey: String
  var partId: String
  var type: String
  var typeKey: String
  var building: String
  var floor: String
  var area: String
  var updatedDate: String
  
  init(id: String, client: String, site: String, systemType: String, autoKey: String, partId: String, type: String, typeKey: String, building: String, floor: String, area: String, updatedDate: String) {
    self.id = id
    self.client = client
    self.site = site
    self.systemType = systemType
    self.autoKey = autoKey
    self.partId = partId
    self.type = type
    self.typeKey = typeKey
    self.building = building
    self.floor = floor
    self.area = area
    self.updatedDate = updatedDate
  }
}
