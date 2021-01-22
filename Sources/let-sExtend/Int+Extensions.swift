//
//  File.swift
//  
//
//  Created by Jakub Łaszczewski on 22/01/2021.
//

import Foundation

public extension Int {
  
  var descriptionWithTwoOrMoreIntPart: String {
    descriptionWithIntPart(noLessThan: 2)
  }
  
  func descriptionWithIntPart(
    noLessThan intPart: Int
  ) -> String {
    String(format: "%0\(intPart)d", self)
  }
}
