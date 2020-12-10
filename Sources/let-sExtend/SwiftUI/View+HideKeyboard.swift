//
//  View+HideKeyboard.swift
//  
//
//  Created by Jakub Łaszczewski on 30/11/2020.
//

import SwiftUI

#if canImport(UIKit)
public extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: nil,
      from: nil,
      for: nil)
  }
}
#endif
