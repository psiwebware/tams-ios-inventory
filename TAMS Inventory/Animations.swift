//
//  Animations.swift
//  TAMS Inventory
//
//  Created by Solomon Kim on 2/14/25.
//

import SwiftUI

struct AnimatedGradientView: View {
  @State private var animateGradient = false
  
  var body: some View {
    ZStack {
      LinearGradient(
        gradient: Gradient(colors: [Color.white, Color("Solo Sky Blue")]),
        startPoint: animateGradient ? .topLeading : .bottomTrailing,
        endPoint: animateGradient ? .bottomTrailing : .topLeading
      )
      .edgesIgnoringSafeArea(.all)
      .animation(Animation.linear(duration: 5).repeatForever(autoreverses: true), value: animateGradient)
      
      VStack {
        Text("Animated Gradient")
          .font(.title)
          .bold()
          .foregroundColor(.black)
      }
    }
    .onAppear {
      animateGradient.toggle()
    }
  }
}

struct ColorChangingGradientView: View {
  @State private var colorShift = false
  
  var body: some View {
    ZStack {
      LinearGradient(
        gradient: Gradient(colors: [
          colorShift ? Color.white : Color("Solo Sky Blue").opacity(0.2),
          colorShift ? Color(red: 0.8, green: 0.9, blue: 1.0) : Color.purple.opacity(0.2)
        ]),
        startPoint: .top,
        endPoint: .bottom
      )
      .edgesIgnoringSafeArea(.all)
      .animation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true), value: colorShift)
      
      VStack {
        Text("Color Changing Gradient")
          .font(.title)
          .bold()
          .foregroundColor(.black)
      }
    }
    .onAppear {
      colorShift.toggle()
    }
  }
}

struct WavyGradientView: View {
  @State private var gradientOffset: CGFloat = 0.0
  
  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: [
        Color.white.opacity(0.7),
        Color("Solo Sky Blue")
      ]),
      startPoint: UnitPoint(x: gradientOffset, y: 0),
      endPoint: UnitPoint(x: 1 - gradientOffset, y: 1)
    )
    .edgesIgnoringSafeArea(.all)
    .onAppear {
      withAnimation(Animation.linear(duration: 6).repeatForever(autoreverses: true)) {
        gradientOffset = 1.0
      }
    }
  }
}

struct AnimatedLavaLampGradient: View {
  @State private var moveX1: CGFloat = 0.3
  @State private var moveY1: CGFloat = 0.3
  @State private var moveX2: CGFloat = 0.7
  @State private var moveY2: CGFloat = 0.7
  
  var body: some View {
    ZStack {
      // First Moving Gradient - White to Light Sky Blue
      RadialGradient(
        gradient: Gradient(colors: [
          Color.white.opacity(0.8),  // More White
          Color("Solo Sky Blue").opacity(0.5) // Softer Blue
        ]),
        center: UnitPoint(x: moveX1, y: moveY1),
        startRadius: 50,  // Make it smaller
        endRadius: 250    // Less spread out, more visible
      )
      .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true), value: moveX1)
      
      // Second Moving Gradient - Light Sky Blue to White
      RadialGradient(
        gradient: Gradient(colors: [
          Color("Solo Sky Blue").opacity(0.5),
          Color.white.opacity(0.8)
        ]),
        center: UnitPoint(x: moveX2, y: moveY2),
        startRadius: 50,
        endRadius: 250    // Same size to keep balance
      )
      .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true), value: moveX2)
    }
    .onAppear {
      moveX1 = 0.7
      moveY1 = 0.7
      moveX2 = 0.3
      moveY2 = 0.3
    }
    .edgesIgnoringSafeArea(.all)
  }
}
