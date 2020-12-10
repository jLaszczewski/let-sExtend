//
//  String+Extensions.swift
//  
//
//  Created by Jakub Łaszczewski on 30/11/2020.
//

import Foundation

public extension String {
  
  func delete(prefix: String) -> String {
    guard hasPrefix(prefix) else {
      return self
    }
    
    return String(dropFirst(prefix.count))
  }
  
  func character(with index: Int) -> String {
    let start = self.index(self.startIndex, offsetBy: index)
    let end = self.index(self.startIndex, offsetBy: index + 1)
    let range = start..<end
    
    return String(self[range])
  }
  
  func int() -> Int? {
    Int(self)
  }
  
  var isNotEmpty: Bool {
    !isEmpty
  }
  
  func slice(
    from fromString: String,
    to toString: String,
    shouldLeaveToString: Bool = false
  ) -> String? {
    (range(of: fromString)?.upperBound).flatMap { substringFrom in
      (range(of: toString, range: substringFrom..<endIndex)?.lowerBound)
        .map { substringTo in
          shouldLeaveToString
            ? String(self[substringFrom..<substringTo]) + toString
            : String(self[substringFrom..<substringTo])
        }
    }
  }
  
  func dropSlice(
    from fromString: String,
    to toString: String
  ) -> String {
    (range(of: fromString)?.lowerBound).flatMap { substringFrom in
      (range(of: toString, range: substringFrom..<endIndex)?.upperBound)
        .map { substringTo in
          var newString = self
          newString.removeSubrange(substringFrom..<substringTo)
          return newString
        }
    } ?? ""
  }
}

public extension Optional where Wrapped == String {
  
  var isNoneOrEmpty: Bool {
    switch self {
    case .none: return true
    case .some: return self?.isEmpty == true
    }
  }
  
  var isSomeAndNotEmpty: Bool {
    !isNoneOrEmpty
  }
}
