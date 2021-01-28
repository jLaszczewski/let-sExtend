//
//  Publisher+Retry.swift
//  
//
//  Created by Jakub Łaszczewski on 11/01/2021.
//

import Combine
import Foundation

public extension Publisher {
  
  func retry(
    _ retries: Int,
    when condition: @escaping (Failure) -> Bool
  ) -> AnyPublisher<Self.Output, Self.Failure> {
    Publishers.ConditionalRetry(self, retries, when: condition)
      .eraseToAnyPublisher()
  }
}


private extension Publishers {
  
  struct ConditionalRetry<P: Publisher>: Publisher {
    
    fileprivate typealias Output = P.Output
    fileprivate typealias Failure = P.Failure
    
    private let publisher: P
    private let retries: Int
    private let condition: (P.Failure) -> Bool
    
    fileprivate init(
      _ publisher: P,
      _ retries: Int,
      when condition: @escaping (P.Failure) -> Bool
    ) {
      self.publisher = publisher
      self.retries = retries
      self.condition = condition
    }
    
    fileprivate func receive<S>(subscriber: S) where S: Subscriber,
                                                Failure == S.Failure,
                                                Output == S.Input {
      publisher
        .catch { (error: P.Failure) -> AnyPublisher<Output, Failure> in
          if condition(error) && retries > 0 {
            return ConditionalRetry(publisher, retries - 1, when: condition)
              .delay(for: 3, scheduler: RunLoop.current)
              .eraseToAnyPublisher()
          } else {
            return error.fail()
          }
        }
        .receive(subscriber: subscriber)
    }
  }
}
