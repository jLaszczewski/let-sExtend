//
//  TargetProtocol.swift
//  
//
//  Created by Jakub Łaszczewski on 02/09/2020.
//

import Foundation

public protocol TargetProtocol {
  
  associatedtype Request: RequestProtocol
  
  var request: Request { get }
}

public extension TargetProtocol {
  
  var baseURL: URL { request.baseURL }
  var path: String { request.path }
  var method: RequestMethod { request.method }
  var headers: [String: String] { request.headers }
  var parameters: [String: String] { request.parameters }
}
