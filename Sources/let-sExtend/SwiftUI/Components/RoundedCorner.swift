//
//  RoundedCorner.swift
//  
//
//  Created by Jakub Łaszczewski on 28/12/2020.
//

import SwiftUI

public struct RoundedCorner: Shape {
  
  public var radius: CGFloat = .infinity
  public var corners: UIRectCorner = .allCorners
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}

// MARK: - Modifier
extension View {
  
  public func cornerRadius(
    _ radius: CGFloat,
    corners: UIRectCorner
  ) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}