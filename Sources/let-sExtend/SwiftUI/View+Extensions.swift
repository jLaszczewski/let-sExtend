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
