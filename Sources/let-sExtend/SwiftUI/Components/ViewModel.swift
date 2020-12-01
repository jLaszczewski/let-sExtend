//
//  ViewModel.swift
//  
//
//  Created by Jakub Łaszczewski on 01/12/2020.
//

import Combine

open class ViewModel: ObservableObject {
  
  public var subscriptions = Set<AnyCancellable>()
  
  @Published public var alert: ViewModelAlert?
  
  public init() {}
}
