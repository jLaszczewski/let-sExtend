//
//  WebView.swift
//  
//
//  Created by ITgenerator on 28/01/2021.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
  
  public let url: URL
  
  public func makeUIView(
    context: UIViewRepresentableContext<WebView>
  ) -> WKWebView {
    let request = URLRequest(url: url)
    let webView = WKWebView()
    webView.load(request)
    return webView
  }
  
  public func updateUIView(
    _ uiView: WKWebView,
    context: UIViewRepresentableContext<WebView>
  ) { }
}
