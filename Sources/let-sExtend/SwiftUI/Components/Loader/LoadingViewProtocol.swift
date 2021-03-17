//
//  LoadingView.swift
//  
//
//  Created by Jakub Łaszczewski on 03/12/2020.
//

import SwiftUI

public struct LoadingView<Content, Style: ProgressViewStyle>: View where Content: View {
  
  @EnvironmentObject private var loader: Loader
  private var style: Style
  private var loadingString: String
  
  private var content: () -> Content
  
  public init(
    style: Style,
    loadingString: String,
    content: @escaping () -> Content
  ) {
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
        width: geometry.frame(in: .local).width,
        height: geometry.frame(in: .local).height)
    }
  }
}

struct LoadingView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView(
      style: DefaultProgressViewStyle(),
      loadingString: "Loading..."
    ) {
      Text("Hello world")
    }
  }
}
