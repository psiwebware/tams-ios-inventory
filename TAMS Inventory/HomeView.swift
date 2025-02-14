//
//  HomeView.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 2/14/25.
//

import SwiftUI

struct HomeView: View {
  @State private var showLoginSheet: Bool = false
  @State private var showActivateSheet: Bool = false
  @State private var showProgressBar: Bool = false
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        VStack {
          Image("Header")
            .resizable()
            .frame(width: 335, height: 110)
          Divider()
            .padding(22)
        }
        .padding(.top, 125)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
        VStack(spacing: 54) {
          Button {
            // Go to Login view
          } label: {
            HStack {
              Text("Login")
              Image(systemName: "arrow.right")
            }
            .frame(width: UIScreen.main.bounds.width - 100, height: 48)
          }
          
          Button(action: {
            showActivateSheet.toggle()
          }, label: {
            HStack {
              Text("Activate")
              Image(systemName: "arrow.right")
            }
            .frame(width: UIScreen.main.bounds.width - 100, height: 48)
          })
          .sheet(isPresented: $showActivateSheet, content: {
            ActivateView()
          })
        }
        .font(.title3)
        .buttonStyle(.borderedProminent)
        .foregroundColor(.white)
        .padding(.top, 22)
        .padding(.bottom, 67)
        
        VStack {
          Image("Management")
        }
        .padding(.top, 7)
        .padding(.bottom, 7)
        
        VStack {
          Text("Version \(AppConfig().version)")
            .fontWeight(.thin)
        }
        .padding(.bottom, 14)
        
        VStack(spacing: 14) {
          Button("Contact Us") {
          }
          Button("SOS") {
          }
          //.background(Color("Solo Red")) // Not fully red because of Bordered Prominent Button Style
        }
        .buttonStyle(.borderedProminent)
        .padding(.bottom, 100)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
      }
      .frame(width: geometry.size.width, height: geometry.size.height)
      .scaleEffect(0.9)
    }
  }
}

#Preview {
  HomeView()
}
