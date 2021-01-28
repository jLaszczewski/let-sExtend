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
    withDelay delay: UInt32 = 0,
    when condition: @escaping (Failure) -> Bool,
    do action: (() -> Self)? = nil
  ) -> AnyPublisher<Self.Output, Self.Failure> {
    Publishers
      .ConditionalRetry(
        self,
        retries,
        withDelay: delay,
        when: condition,
        do: action)
      .eraseToAnyPublisher()
  }
}


private extension Publishers {
  
  struct ConditionalRetry<P: Publisher>: Publisher {
    
    fileprivate typealias Output = P.Output
    fileprivate typealias Failure = P.Failure
    
    private let publisher: P
    private let retries: Int
    private let delay: UInt32
    private let condition: (P.Failure) -> Bool
    private let action: (() -> P)?
    
    fileprivate init(
      _ publisher: P,
      _ retries: Int,
      withDelay delay: UInt32,
      when condition: @escaping (P.Failure) -> Bool,
      do action: (() -> P)? = nil
    ) {
      self.publisher = publisher
      self.retries = retries
      self.delay = delay
      self.condition = condition
      self.action = action
    }
    
    fileprivate func receive<S>(subscriber: S) where S: Subscriber,
                                                     Failure == S.Failure,
                                                     Output == S.Input {
      publisher
        .catch { (error: P.Failure) -> AnyPublisher<Output, Failure> in
          if condition(error) && retries > 0 {
            sleep(UInt32(delay))
            return ConditionalRetry(
              action?() ?? publisher,
              retries - 1,
              withDelay: delay,
              when: condition)
              .eraseToAnyPublisher()
          } else {
            return error.fail()
          }
        }
        .receive(subscriber: subscriber)
    }
  }
}
