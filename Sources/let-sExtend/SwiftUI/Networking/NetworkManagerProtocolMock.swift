//
//  EmptyResponseMock.swift
//  
//
//  Created by Jakub Łaszczewski on 10/12/2020.
//

import Combine
import Foundation

public protocol NetworkManagerProtocolMock: NetworkManagerProtocol {}

public extension NetworkManagerProtocolMock {
  
  func action<ResponseType, ErrorType: Error>(
    response: ResponseType,
    error: ErrorType? = nil
  ) -> AnyPublisher<ResponseType, ErrorType> {
    Future<ResponseType, ErrorType> { promise in
      error.isNone
        ? promise(.success(response))
        : promise(.failure(error!))
    }
    .prefix(1)
    .delay(for: 1, scheduler: RunLoop.main)
    .eraseToAnyPublisher()
  }
}
