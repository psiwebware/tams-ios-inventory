//
//  ActivateViewModel.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 2/28/25.
//

import Foundation
import SwiftData

class ActivateViewModel: ObservableObject {
  //@Published var activateModel = ActivateModel()
  //@Published var userModel: [UserModel] = []
  //@Published var inventoryModel: [InventoryModel] = []
  @Published var partLocationModel: [PartLocationModel] = []
  @Published var poModel: [POModel] = []
  @Published var poPartModel: [POPartModel] = []
  
  @Published var client: String = ""
  @Published var site: String = ""
  @Published var systemType: String = ""
  @Published var systemTypeOptions = ["FAMS", "JAMS"]
  @Published var superUsername: String = ""
  @Published var superPassword: String = ""
  @Published var username: String = ""
  @Published var password: String = ""
  
  @Published var startDate: String = ""
  @Published var endDate: String = ""
  
  @Published var showSheet: Bool = false
  @Published var showPassword: Bool = false
  
  @Published var showAlert: Bool = false
  @Published var alertType: String = ""
  @Published var alertTitle: String = ""
  @Published var alertMessage: String = ""
  
  @Published var isLoading: Bool = false
  @Published var isButtonDisabled: Bool = false
  
  func startLoading() { DispatchQueue.main.async { self.isLoading = true } }
  func stopLoading() { DispatchQueue.main.async { self.isLoading = false } }
  
  // MARK: - Fetch Part Location
  func downloadPartLocation(context: ModelContext, completion: @escaping () -> Void) {
    fetchData(from: "https://psitams.com/m-api/v1/inventory/data/part-location",
              body: ["client": client, "site": site],
              decodeType: [PartLocationDTO].self) { result in
      switch result {
      case .success(let decodedData):
        Task { @MainActor in
          let models = decodedData.map { $0.toModel() }
          self.partLocationModel = models
          self.saveToLocalDatabase(models, context: context)
        }
      case .failure(let error):
        print("[InventoryViewModel] downloadPartLocation() -> Error: \(error)")
      }
      completion()
    }
  }
  
  // MARK: - Fetch PO Data
  func downloadPO(context: ModelContext, completion: @escaping () -> Void) {
    fetchData(from: "https://psitams.com/m-api/v1/inventory/data/po",
              body: ["client": client, "site": site, "startDate": startDate, "endDate": endDate],
              decodeType: [PODTO].self) { result in
      switch result {
      case .success(let decodedData):
        Task { @MainActor in
          let models = decodedData.map { $0.toModel() }
          self.poModel = models
          self.saveToLocalDatabase(models, context: context)
        }
      case .failure(let error):
        print("[InventoryViewModel] downloadPO() -> Error: \(error)")
      }
      completion()
    }
  }
  
  // MARK: - Fetch PO Part Data
  func downloadPOPart(context: ModelContext, completion: @escaping () -> Void) {
    fetchData(from: "https://psitams.com/m-api/v1/inventory/data/po-part",
              body: ["client": client, "site": site, "startDate": startDate, "endDate": endDate],
              decodeType: [POPartDTO].self) { result in
      switch result {
      case .success(let decodedData):
        Task { @MainActor in
          let models = decodedData.map { $0.toModel() }
          self.poPartModel = models
          self.saveToLocalDatabase(models, context: context)
        }
      case .failure(let error):
        print("[InventoryViewModel] downloadPOPart() -> Error: \(error)")
      }
      completion()
    }
  }
  
  // MARK: - Generic Fetch Function
  private func fetchData<T: Decodable>(from urlString: String, body: [String: Any], decodeType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
    guard let url = URL(string: urlString) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("A8qv#pMM.Qaqzr*jBv", forHTTPHeaderField: "Apikey")
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
      guard let data = data, error == nil else {
        completion(.failure(error ?? URLError(.badServerResponse)))
        return
      }
      do {
        let decodedData = try JSONDecoder().decode(decodeType, from: data)
        completion(.success(decodedData))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
  
  // MARK: - Save Data to SwiftData
  private func saveToLocalDatabase<T: PersistentModel>(_ items: [T], context: ModelContext) {
    Task { @MainActor in
      items.forEach { context.insert($0) }
    }
  }
}
