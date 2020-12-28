//
//  Separator.swift
//  iYoni
//
//  Created by Jakub Łaszczewski on 07/12/2020.
//

import SwiftUI

public struct Separator {
  
  public var color: Color
  public var axis: Axis
  public var size: CGFloat = 1
}

extension Separator: View {
  
  var body: some View {
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
