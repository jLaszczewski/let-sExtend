//
//  TrackProgressSubscriber.swift
//  
//
//  Created by Jakub Łaszczewski on 02/12/2020.
//

import Combine
import Foundation

public extension Publisher {

  func trackActivity(
    with loader: Loader
  ) -> AnyPublisher<Self.Output, Self.Failure> {
    Publishers.TrackProgress(self, with: loader)
      .eraseToAnyPublisher()
  }
}

private extension Publishers {
  
  struct TrackProgress<P: Publisher>: Publisher {
    
    fileprivate typealias Output = P.Output
    fileprivate typealias Failure = P.Failure
    
    private let publisher: P
    private let loader: Loader
    
    fileprivate init(
      _ publisher: P,
      with loader: Loader
    ) {
      self.publisher = publisher
      self.loader = loader
    }
    
    fileprivate func receive<S>(subscriber: S) where S: Subscriber,
                                                     Failure == S.Failure,
                                                     Output == S.Input {
      publisher
        .handleEvents(receiveSubscription: { _ in
          DispatchQueue.main.async {
            self.loader.actionsCount += 1
          }
        }, receiveOutput: { _ in
          DispatchQueue.main.async {
            guard self.loader.actionsCount > 0 else { return }
            self.loader.actionsCount -= 1
          }
        }, receiveCompletion: { completion in
          if case .failure = completion {
            DispatchQueue.main.async {
              guard self.loader.actionsCount > 0 else { return }
              self.loader.actionsCount -= 1
            }
          }
        })
        .receive(subscriber: subscriber)
    }
  }
}
