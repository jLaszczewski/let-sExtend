//
//  NetworkManager.swift
//  
//
//  Created by Jakub Łaszczewski on 01/09/2020.
//

import Combine
import Foundation

public protocol NetworkManagerProtocol {
  
  associatedtype Target: TargetProtocol
  
  var subscriptions: Set<AnyCancellable> { get set }
}

open class NetworkManager<Target: TargetProtocol>: NSObject,
                                                     NetworkManagerProtocol {
  
  public var subscriptions = Set<AnyCancellable>()
}
