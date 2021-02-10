//
//  ActivityContainerView.swift
//  
//
//  Created by ITgenerator on 11/02/2021.
//

import SwiftUI

public struct ActivityContainerView<Content>: View where Content: View {
  
  @EnvironmentObject private var loader: Loader
  private var content: () -> Content
  
  public init(
    content: @escaping () -> Content
  ) {
    self.content = content
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .center) {
        self.content()
          .disabled(loader.state == .loading)
        ActivityIndicator(isAnimating: loader.state == .loading)
          .frame(
            maxWidth: .infinity,
            minHeight: 50,
            alignment: .center)
      }
      .frame(
        width: geometry.frame(in: .global).width,
        height: geometry.frame(in: .global).height)
    }
  }
}

// MARK: - Previews
struct ActivityContainerView_Previews: PreviewProvider {
  
  static var previews: some View {
    ActivityContainerView {
      Text("Hello world")
    }
  }
}
