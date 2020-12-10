//
//  EndpointProtocol.swift
//  
//
//  Created by Jakub Łaszczewski on 15/10/2019.
//

public protocol EndpointProtocol where Self: RawRepresentable {
  
  func with(pathParams: CustomStringConvertible...) -> String
}

public extension EndpointProtocol {
  
  func with(pathParams: CustomStringConvertible...) -> String {
    pathParams.reduce("\(rawValue)", { result, pathParam in
      "\(result)/\(pathParam)"
    })
  }
  
  func with(arguments: CVarArg...) -> String {
    String(format: "\(rawValue)", arguments: arguments)
  }
}
