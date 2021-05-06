//
//  RequestParameter.swift
//  
//
//  Created by ITgenerator on 06/05/2021.
//

import Foundation

public final class RequestParameter {
  
  let name: String
  let value: [String]
  
  public init(name: String, value: String) {
    self.name = name
    self.value = [value]
  }
  
  public init(name: String, value: [String]) {
    self.name = name
    self.value = value
  }
}
