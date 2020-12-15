//
//  Dictionary+Extension.swift
//
//
//  Created by Jakub Łaszczewski on 10/04/2019.
//

import Foundation

public extension Dictionary {
  
  static func + (
    left: [Key: Value],
    right: [Key: Value]
  ) -> [Key: Value] {
    var out = left
    
    for (k, v) in right {
      out.updateValue(v, forKey: k)
    }
    
    return out
  }
}
