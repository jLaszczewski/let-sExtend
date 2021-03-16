//
//  Publisher+If.swift
//  
//
//  Created by Jakub Łaszczewski on 16/03/2021.
//

import Combine

public extension Publisher {
  
  func `if`(
    _ condition: Bool,
    if ifTransform: (Self) -> Self
  ) -> Self {
    if condition {
      return ifTransform(self)
    } else {
      return self
    }
  }
}
