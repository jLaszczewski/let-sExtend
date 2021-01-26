//
//  HiddenNavigationLink.swift
//  
//
//  Created by ITgenerator on 26/01/2021.
//

import SwiftUI

public struct HiddenNavigationLink<Destination> : View where Destination : View {

  private let destination: Destination
  private let isActive: Binding<Bool>
  
  public init(destination: Destination, isActive: Binding<Bool>) {
    self.destination = destination
    self.isActive = isActive
  }
  
  public var body: some View {
    NavigationLink(
      "",
      destination: destination,
      isActive: isActive)
    .hidden()
  }
}
