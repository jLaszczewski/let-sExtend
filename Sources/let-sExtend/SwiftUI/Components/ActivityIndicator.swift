//
//  ActivityIndicator.swift
//  
//
//  Created by ITgenerator on 25/01/2021.
//

#if !os(macOS)
import SwiftUI

public struct ActivityIndicator: UIViewRepresentable {
  
  public typealias UIView = UIActivityIndicatorView
  
  private var isAnimating = true
  private var configuration = { (indicator: UIView) in }

  public init(
    isAnimating: Bool,
    configuration: ((UIView) -> Void)? = nil
  ) {
    self.isAnimating = isAnimating
    if let configuration = configuration {
      self.configuration = configuration
    }
  }

  public func makeUIView(
    context: UIViewRepresentableContext<Self>
  ) -> UIView {
    UIView()
  }

  public func updateUIView(
    _ uiView: UIView,
    context: UIViewRepresentableContext<Self>
  ) {
    isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    configuration(uiView)
  }
}
#endif
