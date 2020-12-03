//
//  File.swift
//  
//
//  Created by Jakub Łaszczewski on 03/12/2020.
//

import SwiftUI

public struct LoadingView<Content, Style: ProgressViewStyle>: View where Content: View {
  
  @EnvironmentObject var loader: Loader
  var style: Style
  var loadingString: String
  
  var content: () -> Content
  
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
      style: DefaultProgressViewStyle(),
      loadingString: "Loading...") {
      Text("Hello world")
        .environmentObject(Loader(actionsCount: 1))
    }
  }
}
