//
//  Loader.swift
//  
//
//  Created by Jakub Łaszczewski on 03/12/2020.
//

import Combine

public final class Loader: ObservableObject {
  
  public enum State {
    case loading
    case content
  }
  
  @Published public var state: State = .content
  @Published public var actionsCount: Int = 0 {
    willSet { state = newValue > 0 ? .loading : .content }
  }
  
  public init(actionsCount: Int = 0) {
    self.state = actionsCount > 0 ? .loading : .content
    self.actionsCount = actionsCount
  }
}
