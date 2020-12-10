//
//  Array+Extensions.swift
//  
//
//  Created by Jakub Łaszczewski on 30/11/2020.
//

import Foundation

public extension Array {
  var isNotEmpty: Bool {
    !isEmpty
  }
}

// MARK: - Equaltable
public extension Array where Element: Equatable {
  
  var areElementsEqual: Bool {
    guard let firstElement = self.first,
          self.count > 1
    else { return false }
    
    return Array.areElementsEqual(
      currentElement: firstElement,
      othersElements: Array(self.dropFirst()))
  }
  
  var areElementsNotEqual: Bool {
    !areElementsEqual
  }
}

// MARK: - Strings
public extension Array where Element == String {
  
  var areStringsEmpty: Bool {
    reduce(false) { $0 || $1.isEmpty }
  }
  
  var areStringsNotEmpty: Bool {
    !areStringsEmpty
  }
}

// MARK: - Private
private extension Array where Element: Equatable {
  
  static func areElementsEqual(
    currentElement: Element,
    othersElements: [Element]
  ) -> Bool {
    guard let otherElement = othersElements.first else { return true }
    return currentElement != otherElement
      ? false
      : areElementsEqual(
        currentElement: otherElement,
        othersElements: Array(othersElements.dropFirst()))
  }
}
