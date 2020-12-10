//
//  Encodable+Extensions.swift
//  
//
//  Created by Jakub Łaszczewski on 09/12/2020.
//

import Foundation

public extension Encodable {
  
  func toJSONData(with encoder: JSONEncoder) -> Data? {
    try? encoder.encode(self)
  }
}
