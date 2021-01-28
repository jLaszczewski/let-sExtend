//
//  Loader.swift
//  
//
//  Created by Jakub Łaszczewski on 03/12/2020.
//

import Foundation
import Combine

public final class Loader: ObservableObject {
  
  enum State {
    case loading
    case content
  }
  
  @Published var state: State = .content
  @Published var actionsCount: Int = 0 {
    willSet {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
        self?.state = newValue > 0 ? .loading : .content
      }
    }
  }
  
  public init(actionsCount: Int = 0) {
    self.state = actionsCount > 0 ? .loading : .content
    self.actionsCount = actionsCount
  }
}
