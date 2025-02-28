//
//  ActivateView.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 2/28/25.
//

import SwiftUI

struct ActivateView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var vm = ActivateViewModel()
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        ZStack(alignment: .topTrailing) {
          
          // MARK: Exit Button
          Button(action: {
            DispatchQueue.main.async {
              presentationMode.wrappedValue.dismiss()
            }
          }, label: {
            Image(systemName: "xmark")
              .foregroundColor(Color("Solo Blue"))
              .font(.system(size: 25))
              .padding(17)
              .shadow(color: Color("nuDarkShadow"), radius: 3, x: 2, y: 2)
              .shadow(color: Color("nuLightShadow"), radius: 3, x: -2, y: -2)
          })
          
          VStack(alignment: .center, spacing: 10.0) {
            
            Spacer(minLength: 67)
            
            // MARK: Client TextField
            TextField(text: $vm.client, prompt: Text("Client")) {
              Text("Client")
            }
            .ignoresSafeArea(.keyboard)
            .padding(7)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .frame(width: 333, height: 50)
            .foregroundColor(Color("nuText"))
            .background(Color("nuBackground"))
            .cornerRadius(2)
            .shadow(color: Color("nuDarkShadow"), radius: 3, x: 2, y: 2)
            .shadow(color: Color("nuLightShadow"), radius: 3, x: -2, y: -2)
            
            // MARK: Site TextField
            TextField(text: $vm.site, prompt: Text("Site")) {
              Text("Site")
            }
            .ignoresSafeArea(.keyboard)
            .padding(7)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .frame(width: 333, height: 50)
            .foregroundColor(Color("nuText"))
            .background(Color("nuBackground"))
            .cornerRadius(6)
            .shadow(color: Color("nuDarkShadow"), radius: 3, x: 2, y: 2)
            .shadow(color: Color("nuLightShadow"), radius: 3, x: -2, y: -2)
            
            // MARK: System Type Picker
            Picker("System Type", selection: $vm.systemType) {
              ForEach(vm.systemTypeOptions, id: \.self) { option in
                Text(option).tag(option)
              }
            }
            .pickerStyle(SegmentedPickerStyle()) // or any other style you prefer
            .padding(7)
            .frame(width: 333, height: 50)
            .background(Color("nuBackground"))
            .cornerRadius(6)
            .shadow(color: Color("nuDarkShadow"), radius: 3, x: 2, y: 2)
            .shadow(color: Color("nuLightShadow"), radius: 3, x: -2, y: -2)
            
            // MARK: Supervisor Username TextField
            TextField(text: $vm.superUsername, prompt: Text("Username")) {
              Text("Username")
            }
            .ignoresSafeArea(.keyboard)
            .padding(7)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .frame(width: 333, height: 50)
            .foregroundColor(Color("nuText"))
            .background(Color("nuBackground"))
            .cornerRadius(6)
            .shadow(color: Color("nuDarkShadow"), radius: 3, x: 2, y: 2)
            .shadow(color: Color("nuLightShadow"), radius: 3, x: -2, y: -2)
            
            // MARK: Supervisor Password SecureField
            ZStack(alignment: .trailing) {
              if vm.showPassword {
                TextField("Password", text: $vm.superPassword)
                  .ignoresSafeArea(.keyboard)
                  .padding(7)
                  .disableAutocorrection(true)
                  .textInputAutocapitalization(.never)
                  .frame(width: 333, height: 50)
                  .foregroundColor(Color("nuText"))
                  .background(Color("nuBackground"))
                  .cornerRadius(6)
                  .shadow(color: Color("nuDarkShadow"), radius: 3, x: 2, y: 2)
                  .shadow(color: Color("nuLightShadow"), radius: 3, x: -2, y: -2)
              } else {
                SecureField("Password", text: $vm.superPassword)
                  .ignoresSafeArea(.keyboard)
                  .padding(7)
                  .disableAutocorrection(true)
                  .textInputAutocapitalization(.never)
                  .frame(width: 333, height: 50)
                  .foregroundColor(Color("nuText"))
                  .background(Color("nuBackground"))
                  .cornerRadius(6)
                  .shadow(color: Color("nuDarkShadow"), radius: 3, x: 2, y: 2)
                  .shadow(color: Color("nuLightShadow"), radius: 3, x: -2, y: -2)
              }
              
              // MARK: Eye Button
              Button(action: {
                vm.showPassword.toggle()
              }) {
                Image(systemName: vm.showPassword ? "eye" : "eye.slash")
                  .padding()
              }
            }
            
            Spacer()
              .frame(height: 21)
            
            // MARK: Activate Button
            Button(action: {
              vm.isButtonDisabled = true
              
              DispatchQueue.global(qos: .userInitiated).async {
                //vm.activate()
              }
              
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.67) {
                vm.isButtonDisabled = false
              }
            }, label: {
              Image("Activate")
                .resizable()
                .scaledToFit()
                .frame(width: 137, height: 42) // 147 x 52
                .shadow(color: Color("nuDarkShadow"), radius: 3, x: 2, y: 2)
                .shadow(color: Color("nuLightShadow"), radius: 3, x: -2, y: -2)
            })
            .disabled(vm.isButtonDisabled)
            
            // MARK: Alert DialogBox
            .alert(isPresented: $vm.showAlert, content: {
              Alert(
                title: Text(vm.alertTitle),
                message: Text(vm.alertMessage),
                dismissButton: .default(Text("Ok"), action: {
                  if vm.alertType == "Valid" {
                    DispatchQueue.main.async {
                      self.presentationMode.wrappedValue.dismiss()
                    }
                  }
                })
              )
            })
          }
          .offset(y: 150)
          .padding(.bottom, 367)
          .ignoresSafeArea(.keyboard)
          .frame(width: geometry.size.width)
          .frame(minHeight: geometry.size.height)
          //.frame(maxWidth: geometry.size.width)
          //.frame(maxHeight: geometry.size.height)
        }
        
        // MARK: Loading Animation
        if vm.isLoading {
          ZStack {
            Rectangle()
              .fill(Color("Solo Gray"))
              .opacity(0.267)
              .ignoresSafeArea()
              .allowsHitTesting(true)
            
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: Color("Solo Blue")))
              .scaleEffect(1.67)
          }
        }
      }
      .onAppear(perform: {
//        vm.getActivationCredentials({
//        })
      })
    }
  }
}

