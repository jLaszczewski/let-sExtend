//
//  File.swift
//  
//
//  Created by ITgenerator on 07/01/2021.
//

import SwiftUI

public struct ColoredToggleStyle: ToggleStyle {
  
  private let leftTintColor: Color
  private let rightTintColor: Color
  private let leftCircleColor: Color
  private let rightCircleColor: Color
  
  public init(
    leftTintColor: Color,
    rightTintColor: Color,
    leftCircleColor: Color,
    rightCircleColor: Color
  ) {
    self.leftTintColor = leftTintColor
    self.rightTintColor = rightTintColor
    self.leftCircleColor = leftCircleColor
    self.rightCircleColor = rightCircleColor
  }
  
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
      Spacer()
      Rectangle()
        .foregroundColor(
          configuration.isOn
            ? leftTintColor
            : rightTintColor)
        .frame(width: 51, height: 31, alignment: .center)
        .overlay(
          Circle()
            .foregroundColor(
              configuration.isOn
                ? leftCircleColor
                : rightCircleColor)
            .padding(.all, 3)
            .offset(x: configuration.isOn ? 11 : -11, y: 0)
            .animation(Animation.linear(duration: 0.1))
        )
        .cornerRadius(20)
        .onTapGesture { configuration.isOn.toggle() }
    }
  }
}
