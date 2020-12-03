//
//  File.swift
//  
//
//  Created by Jakub Łaszczewski on 03/12/2020.
//

import SwiftUI

public protocol LoadingView: View {
  
  associatedtype Content: View
  associatedtype Style: ProgressViewStyle
  
  @EnvironmentObject public var loader: Loader { get }
  public var style: Style { get }
  public var loadingString: { get }
  
  public var content: () -> Content
  
  public init(
    loader: Loader,
    style: Style,
    loadingString: String,
    content: @escaping () -> Content
  ) {
    self.loader = loader
    self.style = style
    self.loadingString = loadingString
    self.content = content
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .center) {
        self.content()
          .disabled(loader.state == .loading)
          .blur(radius: loader.state == .loading ? 3 : 0)
        
        VStack {
          Text(loadingString)
          ProgressView().progressViewStyle(style)
        }
        .frame(
          width: geometry.frame(in: .global).width / 2,
          height: geometry.frame(in: .global).height / 5)
        .background(Color.secondary.colorInvert())
        .foregroundColor(Color.primary)
        .cornerRadius(20)
        .opacity(loader.state == .loading ? 1 : 0)
      }
      .frame(
        width: geometry.frame(in: .global).width,
        height: geometry.frame(in: .global).height)
    }
  }
}

struct LoadingView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView(
      loader: Loader(),
      style: DefaultProgressViewStyle(),
      loadingString: "Loading..."
    ) {
      Text("Hello world")
    }
  }
}
