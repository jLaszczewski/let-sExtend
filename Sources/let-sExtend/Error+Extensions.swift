//
//  Error+Extensions.swift
//  
//
//  Created by Jakub Łaszczewski on 10/12/2020.
//

import Combine

extension Error {
  
  func fail<Output, Faliure: Error>() -> AnyPublisher<Output, Faliure> {
    Fail<Output, Faliure>(error: self as! Faliure).eraseToAnyPublisher()
  }
}
