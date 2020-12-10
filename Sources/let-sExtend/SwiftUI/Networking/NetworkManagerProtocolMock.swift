//
//  EmptyResponseMock.swift
//  
//
//  Created by Jakub Łaszczewski on 10/12/2020.
//

import Combine
import Foundation

struct EmptyResponseMock: Encodable {}

protocol NetworkManagerProtocolMock: NetworkManagerProtocol {
  
  var error: URLError? { get set }
}

extension NetworkManagerProtocolMock {
  
  func action<E: Encodable>(
    response: E? = nil, _ type: E.Type
  ) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    Future<(data: Data, response: URLResponse), URLError> { promise in
      let encoder = JSONEncoder()
      let responseData = try? encoder.encode(response)
      
      self.error.isNone
        ? promise(.success((data: responseData ?? Data(), response: HTTPURLResponse())))
        : promise(.failure(error!))
    }
    .prefix(1)
    .delay(for: 1, scheduler: RunLoop.main)
    .eraseToAnyPublisher()
  }
}
