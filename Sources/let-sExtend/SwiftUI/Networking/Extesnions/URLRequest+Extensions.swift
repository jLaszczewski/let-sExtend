//
//  URLRequest+Extensions.swift
//  
//
//  Created by Jakub Łaszczewski on 09/12/2020.
//

import Foundation

extension URLRequest {
  
  var headers: [String: String] {
    get { allHTTPHeaderFields ?? [:] }
    set { newValue.forEach { setValue($0.value, forHTTPHeaderField: $0.key) } }
  }
}
