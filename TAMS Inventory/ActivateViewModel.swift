//
//  ActivateViewModel.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 2/28/25.
//

import Foundation

class ActivateViewModel: ObservableObject {
  //@Published var activateModel = ActivateModel()
  //@Published var userModel: [UserModel] = []
  //@Published var inventoryModel: [InventoryModel] = []
  
  @Published var client: String = ""
  @Published var site: String = ""
  @Published var systemType: String = ""
  @Published var systemTypeOptions = ["FAMS", "JAMS"]
  @Published var superUsername: String = ""
  @Published var superPassword: String = ""
  @Published var username: String = ""
  @Published var password: String = ""
  
  @Published var showSheet: Bool = false
  @Published var showPassword: Bool = false
  
  @Published var showAlert: Bool = false
  @Published var alertType: String = ""
  @Published var alertTitle: String = ""
  @Published var alertMessage: String = ""
  
  @Published var isLoading: Bool = false
  @Published var isButtonDisabled: Bool = false
}

