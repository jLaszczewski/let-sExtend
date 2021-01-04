//
//  Separator.swift
//  iYoni
//
//  Created by Jakub Łaszczewski on 07/12/2020.
//

import SwiftUI

public struct Separator {
  
  public let color: Color
  public let axis: Axis
  public let size: CGFloat
  
  public init(
    color: Color,
    axis: Axis,
    size: CGFloat = 1
  ) {
    self.color = color
    self.axis = axis
    self.size = size
  }
}

extension Separator: View {
  
  public var body: some View {
    if axis == Axis.horizontal {
      color.frame(height: size)
    } else {
      color.frame(width: size)
    }
  }
}

struct Separator_Previews: PreviewProvider {
  
  static var previews: some View {
    Separator(color: .black, axis: .horizontal, size: 1)
      .previewLayout(.fixed(width: 288, height: 80))
  }
}
