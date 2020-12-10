//
//  URL+Extensions.swift
//  
//
//  Created by Jakub Łaszczewski on 09/12/2020.
//

import Foundation

extension URL {
  
  func appending(
    pathComponent: String,
    queryItems: [URLQueryItem]? = nil
  ) -> URL? {
    var urlComponetns = URLComponents(
      string: appendingPathComponent(pathComponent).absoluteString
    )
    urlComponetns?.queryItems = queryItems
    
    return urlComponetns?.url
  }
}
