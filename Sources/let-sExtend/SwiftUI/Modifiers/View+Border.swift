//
//  View+Border.swift
//
//
//  Created by Jakub Łaszczewski on 17/11/2020.
//

import SwiftUI

public extension View {
  
  func border<S: ShapeStyle>(
    _ content: S,
    width: CGFloat = 1,
    cornerRadius: CGFloat
  ) -> some View {
    self.overlay(
      RoundedRectangle(cornerRadius: cornerRadius)
        .strokeBorder(content, lineWidth: width))
  }
}

public extension View {
  
  func border<S: ShapeStyle>(
    _ content: S,
    strokeType: StrokeStyle,
    cornerRadius: CGFloat
  ) -> some View {
    self.overlay(
      RoundedRectangle(cornerRadius: cornerRadius)
        .strokeBorder(content, style: strokeType))
  }
}

public extension View {
  
  func border(
    edges: [Edge],
    color: Color,
    style: StrokeStyle) -> some View {
    overlay(
      EdgeBorder(edges: edges)
        .stroke(color, style: style))
  }
}
