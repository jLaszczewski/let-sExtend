//
//  Optional+Extensions.swift
//  
//
//  Created by Jakub Łaszczewski on 01/12/2020.
//

import Foundation

public extension Optional {
  
  var isNone: Bool {
    switch self {
    case .none: return true
    case .some: return false
    }
  }
  
  var isSome: Bool {
    !isNone
  }
}

// MARK: - Optional Bool
public extension Optional where Wrapped == Bool {
  
  var isNoneOrFalse: Bool {
    guard let self = self else { return true }
    return !self
  }
}
