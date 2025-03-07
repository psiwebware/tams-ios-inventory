//
//  MainView.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 3/4/25.
//

import SwiftUI

struct MainViewIterationOne: View {
  @State private var selectedLocation = "Location 1"
  @State private var selectedType = "Type A"
  @State private var items = [Itemx(id: 1, name: "Item 1"), Itemx(id: 2, name: "Item 2"), Itemx(id: 3, name: "Item 3")]
  
  var locationOptions = ["Location 1", "Location 2", "Location 3"]
  var typeOptions = ["Type A", "Type B", "Type C"]
  
  @State private var showDownloadUploadActionSheet = false
  
  var downloadUploadActionSheet: ActionSheet {
    ActionSheet(
      title: Text("Choose an action"),
      buttons: [
        .default(Text("Download")) {
          // Download action
        },
        .default(Text("Upload")) {
          // Upload action
        },
        .cancel()
      ]
    )
  }
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Picker("Location", selection: $selectedLocation) {
            ForEach(locationOptions, id: \.self) { location in
              Text(location)
            }
          }
          .pickerStyle(.inline)
          
          Picker("Type", selection: $selectedType) {
            ForEach(typeOptions, id: \.self) { type in
              Text(type)
            }
          }
          .pickerStyle(.inline)
        }
        .padding()
        
        List {
          ForEach(items, id: \.id) { item in
            Text(item.name)
          }
        }
        .padding(.horizontal)
        
        HStack {
          Button("Download/Upload") {
            showDownloadUploadActionSheet = true
          }
          .actionSheet(isPresented: $showDownloadUploadActionSheet) {
            downloadUploadActionSheet
          }
          
          Button("Receive") {
            // Receive action
          }
          .buttonStyle(.borderedProminent)
        }
        .padding()
      }
      .navigationBarTitle("Inventory Management")
    }
  }
}

#Preview {
  MainViewIterationOne()
}

struct Itemx: Identifiable {
  var id: Int
  var name: String
}


/// -----------------------------------------------------------------------------------------

struct MainView: View {
  @State private var selectedLocation = "Main Warehouse"
  @State private var selectedType = "All Types"
  @State private var showFilters = false
  @State private var inventoryItems: [InventoryItem] = [] // Populate from your VM
  
  let locations = ["Main Warehouse", "Retail Store", "Storage Unit 5"]
  let types = ["All Types", "Electronics", "Furniture", "Consumables", "Raw Materials"]
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        // Control Section
        VStack(spacing: 16) {
          // Action Buttons
          HStack(spacing: 16) {
            ActionButton(title: "Download", systemImage: "arrow.down.circle") {}
            ActionButton(title: "Upload", systemImage: "arrow.up.circle") {}
            ActionButton(title: "Receive", systemImage: "shippingbox") {}
          }
          .padding(.horizontal)
          
          // Filter Controls
          HStack(spacing: 16) {
            FilterMenu(selection: $selectedLocation, options: locations)
            FilterMenu(selection: $selectedType, options: types)
          }
          .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color(.systemGroupedBackground))
        
        // Inventory List
        List {
          ForEach(inventoryItems) { item in
            InventoryRow(item: item)
              .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
          }
        }
        .listStyle(.plain)
      }
      .navigationTitle("Inventory")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button("Filters", systemImage: "line.3.horizontal.decrease.circle") {
            showFilters.toggle()
          }
        }
      }
    }
  }
}

// Reusable Components
struct ActionButton: View {
  let title: String
  let systemImage: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Label(title, systemImage: systemImage)
        .frame(maxWidth: .infinity)
        .font(.subheadline.weight(.medium))
    }
    .buttonStyle(.borderedProminent)
    .controlSize(.large)
  }
}

struct FilterMenu: View {
  @Binding var selection: String
  let options: [String]
  
  var body: some View {
    Menu {
      Picker("", selection: $selection) {
        ForEach(options, id: \.self) { option in
          Text(option).tag(option)
        }
      }
    } label: {
      HStack {
        Text(selection)
          .foregroundColor(.primary)
        
        Image(systemName: "chevron.down")
          .imageScale(.small)
      }
      .padding(.horizontal)
      .frame(maxWidth: .infinity, minHeight: 44)
      .background(Color(.secondarySystemGroupedBackground))
      .cornerRadius(10)
    }
  }
}

struct InventoryRow: View {
  let item: InventoryItem
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      Image(systemName: "cube.box")
        .foregroundColor(.accentColor)
        .imageScale(.large)
        .frame(width: 40)
      
      VStack(alignment: .leading, spacing: 4) {
        Text(item.name)
          .font(.headline)
        
        HStack(spacing: 16) {
          Text(item.location)
            .font(.subheadline)
            .foregroundColor(.secondary)
          
          Text(item.type)
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Capsule().fill(Color.accentColor))
        }
      }
      
      Spacer()
      
      Text("\(item.quantity)")
        .font(.title3.monospacedDigit())
        .foregroundColor(.primary)
    }
    .padding(.vertical, 8)
  }
}

// Preview with sample data
//#Preview {
//    MainView(inventoryItems: [
//        InventoryItem(name: "MacBook Pro M2", location: "Retail Store", type: "Electronics", quantity: 42),
//        InventoryItem(name: "Office Chair", location: "Main Warehouse", type: "Furniture", quantity: 15),
//        InventoryItem(name: "Shipping Boxes", location: "Storage Unit 5", type: "Consumables", quantity: 200)
//    ])
//}

struct InventoryItem: Identifiable {
  let id = UUID()
  let name: String
  let location: String
  let type: String
  let quantity: Int
}



struct MainViewIterationTwo: View {
  @StateObject var viewModel = MainViewModel()
  
  var body: some View {
    NavigationView {
      VStack(spacing: 16) {
        // Buttons Row
        HStack(spacing: 16) {
          Button(action: {
            viewModel.handleDownloadUpload()
          }) {
            Text("Download/Upload")
              .fontWeight(.semibold)
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.blue)
              .foregroundColor(.white)
              .cornerRadius(8)
          }
          
          Button(action: {
            viewModel.handleReceive()
          }) {
            Text("Receive")
              .fontWeight(.semibold)
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.green)
              .foregroundColor(.white)
              .cornerRadius(8)
          }
        }
        .padding(.horizontal, 16)
        
        // Dropdowns Row
        HStack(spacing: 16) {
          // Location Picker
          Picker("Location", selection: $viewModel.selectedLocation) {
            ForEach(viewModel.locations, id: \.self) { location in
              Text(location)
            }
          }
          .pickerStyle(MenuPickerStyle())
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(8)
          
          // Type Picker
          Picker("Type", selection: $viewModel.selectedType) {
            ForEach(viewModel.types, id: \.self) { type in
              Text(type)
            }
          }
          .pickerStyle(MenuPickerStyle())
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(8)
        }
        .padding(.horizontal, 16)
        
        // Inventory Items List
        List {
          ForEach(viewModel.items) { item in
            InventoryItemRow(item: item)
          }
        }
        .listStyle(PlainListStyle())
      }
      .navigationTitle("Inventory Management")
    }
  }
}

struct InventoryItemRow: View {
  let item: InventoryItemx
  
  var body: some View {
    HStack {
      Text(item.name)
      Spacer()
      Text("\(item.quantity)")
        .foregroundColor(.secondary)
    }
    .padding(.vertical, 8)
  }
}

struct InventoryItemx: Identifiable {
  let id = UUID()
  let name: String
  let quantity: Int
}

class MainViewModel: ObservableObject {
  @Published var selectedLocation: String = "Warehouse"
  @Published var selectedType: String = "All"
  @Published var items: [InventoryItemx] = [
    InventoryItemx(name: "Item 1", quantity: 10),
    InventoryItemx(name: "Item 2", quantity: 5),
    InventoryItemx(name: "Item 3", quantity: 12)
  ]
  
  let locations = ["Warehouse", "Store", "Online"]
  let types = ["All", "Electronics", "Apparel", "Food"]
  
  func handleDownloadUpload() {
    // Add logic for download/upload functionality
  }
  
  func handleReceive() {
    // Add logic for receive functionality
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainViewIterationTwo()
  }
}
