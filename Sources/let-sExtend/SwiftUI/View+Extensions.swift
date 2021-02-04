//
//  View+Extensions.swift
//  
//
//  Created by Jakub Łaszczewski on 01/12/2020.
//

import SwiftUI

public extension Text {
  
  init?(_ key: String?) {
    guard let key = key else { return nil }
    self = Text(key)
  }
}

public extension View {
  
  @ViewBuilder func hidden(_ hidden: Bool) -> some View {
    switch hidden {
    case true: self.hidden()
    case false: self
    }
  }
}

public extension View {
  
  @ViewBuilder
  func `if`<TrueContent: View>(
    _ condition: Bool,
    if ifTransform: (Self) -> TrueContent
  ) -> some View {
    if condition {
      ifTransform(self)
    } else {
      self
    }
  }
  
  @ViewBuilder
  func `if`<TrueContent: View, FalseContent: View>(
    _ condition: Bool,
    if ifTransform: (Self) -> TrueContent,
    else elseTransform: (Self) -> FalseContent
  ) -> some View {
    if condition {
      ifTransform(self)
    } else {
      elseTransform(self)
    }
  }
}
