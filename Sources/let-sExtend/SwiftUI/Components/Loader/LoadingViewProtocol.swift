//
//  LoadingViewProtocol.swift
//  
//
//  Created by Jakub Łaszczewski on 03/12/2020.
//

import SwiftUI

public protocol LoadingViewProtocol: View {
  
  associatedtype Content: View
  associatedtype Style: ProgressViewStyle
  
  var loader: Loader { get set }
  
  var style: Style { get }
  var loadingString: String { get }
  
  var content: () -> Content { get }
  
  init(
    style: Style,
    loadingString: String,
    content: @escaping () -> Content
  )
}

extension LoadingViewProtocol {
  
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
