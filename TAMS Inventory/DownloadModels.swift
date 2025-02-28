//
//  DownloadModels.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 2/28/25.
//

import SwiftData

@Model
class PartLocationModel: Codable {
  @Attribute(.unique) var id: Int = 0
  var facilityID: String
  var building: String
  var floor: String
  var zone: String
  var room: String
  var partID: String
  var onHand: Int
  var autoKey: Int
  
  init(facilityID: String, building: String, floor: String, zone: String, room: String, partID: String, onHand: Int, autoKey: Int) {
    self.facilityID = facilityID
    self.building = building
    self.floor = floor
    self.zone = zone
    self.room = room
    self.partID = partID
    self.onHand = onHand
    self.autoKey = autoKey
  }
}

@Model
class POModel {
  @Attribute(.unique) var id: Int = 0
  var facilityID: String
  var pono: String
  var requisitionNo: String
  var deliveryDate: String
  var orderedDate: String
  var status: String
  var autoKey: Int
  
  init(facilityID: String, pono: String, requisitionNo: String, deliveryDate: String, orderedDate: String, status: String, autoKey: Int) {
    self.facilityID = facilityID
    self.pono = pono
    self.requisitionNo = requisitionNo
    self.deliveryDate = deliveryDate
    self.orderedDate = orderedDate
    self.status = status
    self.autoKey = autoKey
  }
}

@Model
class POPartModel {
  @Attribute(.unique) var id: Int = 0
  var facilityID: String
  var pono: String
  var requisitionNo: String
  var partID: String
  var building: String
  var floor: String
  var zone: String
  var room: String
  var quantity: Int
  var receivedQty: String
  var backOrdered: String
  var cancelled: String
  var status: String
  var autoKey: Int
  
  init(facilityID: String, pono: String, requisitionNo: String, partID: String, building: String, floor: String, zone: String, room: String, quantity: Int, receivedQty: String = "", backOrdered: String = "", cancelled: String = "", status: String = "", autoKey: Int) {
    self.facilityID = facilityID
    self.pono = pono
    self.requisitionNo = requisitionNo
    self.partID = partID
    self.building = building
    self.floor = floor
    self.zone = zone
    self.room = room
    self.quantity = quantity
    self.receivedQty = receivedQty
    self.backOrdered = backOrdered
    self.cancelled = cancelled
    self.status = status
    self.autoKey = autoKey
  }
}

