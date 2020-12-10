//
//  NetworkManager.swift
//  
//
//  Created by Jakub Łaszczewski on 01/09/2020.
//

import Combine
import Foundation

protocol NetworkManagerProtocol {
  
  associatedtype Target: TargetProtocol
  
  var subscriptions: Set<AnyCancellable> { get set }
}

class NetworkManager<Target: TargetProtocol>: NSObject, NetworkManagerProtocol {
  
  var subscriptions = Set<AnyCancellable>()
}
