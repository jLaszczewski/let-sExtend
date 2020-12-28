//
//  RoundedCorner.swift
//  
//
//  Created by Jakub Łaszczewski on 28/12/2020.
//

import SwiftUI

struct RoundedCorner: Shape {
  
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
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
  
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}
