//
//  TrackProgressSubscriber.swift
//  
//
//  Created by Jakub Łaszczewski on 02/12/2020.
//

import Combine
import Foundation

public extension Publisher {

  func trackActivity(with loader: Loader) -> Self {
    receive(on: RunLoop.main)
      .subscribe(TrackProgressSubscriber(loader: loader))
      
    return self
  }
}

private final class TrackProgressSubscriber<Input, Faliure: Error>: Subscriber {
  
  var loader: Loader
  
  init(loader: Loader) {
    self.loader = loader
  }
  
  func receive(subscription: Subscription) {
    loader.actionsCount += 1
    subscription.request(.unlimited)
  }
  
  func receive(_ input: Input) -> Subscribers.Demand {
    return .none
  }
  
  func receive(completion: Subscribers.Completion<Faliure>) {
    guard loader.actionsCount > 0 else { return }
    loader.actionsCount -= 1
  }
}
