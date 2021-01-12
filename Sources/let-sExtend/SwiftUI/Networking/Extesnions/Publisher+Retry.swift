//
//  Publisher+Retry.swift
//  
//
//  Created by Jakub Łaszczewski on 11/01/2021.
//

import Combine
import Foundation

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
      
      publisher
        .catch { (error: P.Failure) -> AnyPublisher<Output, Failure> in
        if condition(error)  {
          sleep(UInt32(1))
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
