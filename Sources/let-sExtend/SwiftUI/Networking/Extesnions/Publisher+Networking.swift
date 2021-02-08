//
//  Publisher+Networking.swift
//  
//
//  Created by Jakub Łaszczewski on 10/12/2020.
//

import Combine
import Foundation

public extension Publisher where Output == (data: Data, response: URLResponse) {

  func filterSuccessfulStatus(
    isDebugging: Bool,
    filterFucntion: @escaping (
      URLResponse,
      Data,
      Bool
    ) -> Result<Data, Failure>
  ) -> AnyPublisher<Data, Failure> {
    flatMap { result -> AnyPublisher<Data, Failure> in
      switch filterFucntion(
        result.response,
        result.data,
        isDebugging) {
      case let .success(data):
        return Just(data)
          .setFailureType(to: Failure.self)
          .eraseToAnyPublisher()
      case let .failure(error):
        return error.fail()
      }
    }
    .eraseToAnyPublisher()
  }
}

public extension Publisher where Output == Data {
  
  func map<D: Decodable>(
    _ type: D.Type,
    atKeyPath keyPath: String? = nil,
    using decoder: JSONDecoder = JSONDecoder()
  ) -> AnyPublisher<D, Error> {
    tryMap {
      do {
        if let keyPath = keyPath,
           let json = try? JSONSerialization.jsonObject(with: $0),
           let nestedJson = (json as AnyObject).value(forKeyPath: keyPath),
           let nestedJsonData = try? JSONSerialization.data(withJSONObject: nestedJson) {
          
          return try decoder.decode(type, from: nestedJsonData)
        } else {
          return try decoder.decode(type, from: $0)
        }
      } catch {
        throw error
      }
    }
    .eraseToAnyPublisher()
  }
}


public extension Publisher {
  
  func mapToEmpty() -> AnyPublisher<Void, Failure> {
    map { _ in () }.eraseToAnyPublisher()
  }
}

public extension Just {
  
  func withFailureType<E: Error>() -> AnyPublisher<Output, E> {
    setFailureType(to: E.self)
      .eraseToAnyPublisher()
  }
  
  func withFailureType<E: Error>(_ type: E.Type) -> AnyPublisher<Output, E> {
    setFailureType(to: type)
      .eraseToAnyPublisher()
  }
}
