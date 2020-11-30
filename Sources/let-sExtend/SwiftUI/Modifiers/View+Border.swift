//
//  View+Border.swift
//
//
//  Created by Jakub Łaszczewski on 17/11/2020.
//

import SwiftUI

extension View {
  
  public func border<S: ShapeStyle>(
    _ content: S,
    width: CGFloat = 1,
    cornerRadius: CGFloat
  ) -> some View {
    self.overlay(
      RoundedRectangle(cornerRadius: cornerRadius)
        .strokeBorder(content, lineWidth: width))
  }
}
