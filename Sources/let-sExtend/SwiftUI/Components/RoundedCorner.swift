//
//  RoundedCorner.swift
//  
//
//  Created by Jakub Łaszczewski on 28/12/2020.
//

#if !os(macOS)
import SwiftUI

public struct RoundedCorner: Shape {
  
  public var radius: CGFloat = .infinity
  public var corners: UIRectCorner = .allCorners
  
  public init(
    radius: CGFloat,
    corners: UIRectCorner
  ) {
    self.radius = radius
    self.corners = corners
  }
  
  public func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}

// MARK: - Modifier
public extension View {
  
  func cornerRadius(
    _ radius: CGFloat,
    corners: UIRectCorner
  ) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}
#endif
