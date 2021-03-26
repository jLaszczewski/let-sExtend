//
//  ViewModel.swift
//  
//
//  Created by Jakub Łaszczewski on 01/12/2020.
//

import Foundation
import Combine

open class ViewModel: NSObject, ObservableObject {
  
  public var subscriptions = Set<AnyCancellable>()
  
  @Published public var alert: ViewModelAlert?
  
  public override init() {
    super.init()
  }
}
