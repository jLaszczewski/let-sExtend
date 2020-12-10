//
//  Request.swift
//
//
//  Created by Jakub Łaszczewski on 01/09/2020.
//

import Foundation

public enum RequestMethod: String {
  
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

public protocol RequestProtocol {
  
  var baseURL: URL { get }
  var path: String { get }
  var method: RequestMethod { get }
  var headers: [String: String] { get }
  var parameters: [String: String] { get }
  var body: Data? { get }
}

// MARK: - Getters
public extension RequestProtocol {
  
  var url: URL {
    if queryItems.isEmpty {
      return baseURL.appending(pathComponent: path)!
    }
    return baseURL.appending(
      pathComponent: path,
      queryItems: queryItems)!
  }
  
  var urlRequest: URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.headers = headers
    request.httpBody = body
    
    return request
  }
}

// MARK: - Private getters
private extension RequestProtocol {
  
  var queryItems: [URLQueryItem] {
    parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
  }
}
