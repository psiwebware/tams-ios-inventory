//
//  DownloadDTOs.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 2/28/25.
//

import Foundation

struct PartLocationDTO: Codable {
  var facilityID: String
  var building: String
  var floor: String
  var zone: String
  var room: String
  var partID: String
  var onHand: Int
  var autoKey: Int
  
  func toModel() -> PartLocationModel {
    return PartLocationModel(
      facilityID: facilityID,
      building: building,
      floor: floor,
      zone: zone,
      room: room,
      partID: partID,
      onHand: onHand,
      autoKey: autoKey
    )
  }
}

struct PODTO: Codable {
  var facilityID: String
  var pono: String
  var requisitionNo: String
  var deliveryDate: String
  var orderedDate: String
  var status: String
  var autoKey: Int
  
  func toModel() -> POModel {
    return POModel(
      facilityID: facilityID,
      pono: pono,
      requisitionNo: requisitionNo,
      deliveryDate: deliveryDate,
      orderedDate: orderedDate,
      status: status,
      autoKey: autoKey
    )
  }
}

struct POPartDTO: Codable {
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
  
  func toModel() -> POPartModel {
    return POPartModel(
      facilityID: facilityID,
      pono: pono,
      requisitionNo: requisitionNo,
      partID: partID,
      building: building,
      floor: floor,
      zone: zone,
      room: room,
      quantity: quantity,
      receivedQty: receivedQty,
      backOrdered: backOrdered,
      cancelled: cancelled,
      status: status,
      autoKey: autoKey
    )
  }
}
