//
//  EmptyResponseMock.swift
//  
//
//  Created by Jakub Łaszczewski on 10/12/2020.
//

import Combine
import Foundation

public struct EmptyResponseMock: Encodable {}

public protocol NetworkManagerProtocolMock: NetworkManagerProtocol {
}

public extension NetworkManagerProtocolMock {
  
  func action<E: Encodable, ErrorType: Error>(
    response: E,
    error: ErrorType? = nil
  ) -> AnyPublisher<E, ErrorType> {
    Future<E, ErrorType> { promise in
      error.isNone
        ? promise(.success(response))
        : promise(.failure(error!))
    }
    .prefix(1)
    .delay(for: 1, scheduler: RunLoop.main)
    .eraseToAnyPublisher()
  }
}
