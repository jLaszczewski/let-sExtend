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
    
    guard let query = urlComponetns!.query, let baseURL = baseURL else { return }
    return URL(string: baseURL.absoluteString + query)
  }
}
