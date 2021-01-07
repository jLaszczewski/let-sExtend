//
//  ColoredToggleStyle.swift
//  
//
//  Created by ITgenerator on 07/01/2021.
//

import SwiftUI

public struct ColoredToggleStyle: ToggleStyle {
  
  private let isOnTintColor: Color
  private let isOffTintColor: Color
  private let isOnCircleColor: Color
  private let isOffCircleColor: Color
  
  public init(
    isOnTintColor: Color,
    isOffTintColor: Color,
    isOnCircleColor: Color,
    isOffCircleColor: Color
  ) {
    self.isOnTintColor = isOnTintColor
    self.isOffTintColor = isOffTintColor
    self.isOnCircleColor = isOnCircleColor
    self.isOffCircleColor = isOffCircleColor
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
      Spacer()
      Rectangle()
        .foregroundColor(
          configuration.isOn
            ? isOnTintColor
            : isOffTintColor)
        .frame(width: 51, height: 31, alignment: .center)
        .overlay(
          Circle()
            .foregroundColor(
              configuration.isOn
                ? isOnCircleColor
                : isOffCircleColor)
            .padding(.all, 3)
            .offset(x: configuration.isOn ? 11 : -11, y: 0)
            .animation(Animation.linear(duration: 0.1))
        )
        .cornerRadius(20)
        .onTapGesture { configuration.isOn.toggle() }
    }
  }
}
