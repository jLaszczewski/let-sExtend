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
    isDebuging: Bool,
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
        isDebuging) {
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
    using decoder: JSONDecoder = JSONDecoder()
  ) -> AnyPublisher<D, Error> {
    tryMap {
      do {
        return try decoder.decode(type, from: $0)
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
}

public extension Publishers {
  
  struct ConditionalRetry<P: Publisher>: Publisher {
    
    public typealias Output = P.Output
    public typealias Failure = P.Failure
    
    private let publisher: P
    private let retries: Int
    private let condition: (P.Failure) -> Bool
    
    public init(
      _ publisher: P,
      _ retries: Int,
      when condition: @escaping (P.Failure) -> Bool
    ) {
      self.publisher = publisher
      self.retries = retries
      self.condition = condition
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber,
                                         Failure == S.Failure,
                                         Output == S.Input {
      guard retries > 0
      else { return publisher.receive(subscriber: subscriber) }
      
      publisher.catch { (error: P.Failure) -> AnyPublisher<Output, Failure> in
        if condition(error)  {
          return ConditionalRetry(publisher, retries - 1, when: condition)
            .eraseToAnyPublisher()
        } else {
          return error.fail()
        }
      }
      .receive(subscriber: subscriber)
    }
  }
}

public extension Publisher {
  
  func retry(
    _ retries: Int,
    when condition: @escaping (Failure) -> Bool
  ) -> Publishers.ConditionalRetry<Self> {
    Publishers.ConditionalRetry(self, retries, when: condition)
  }
}
