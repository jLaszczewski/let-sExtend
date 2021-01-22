//
//  PageControl.swift
//  
//
//  Created by ITgenerator on 03/12/2020.
//

#if !os(macOS)
import UIKit
import SwiftUI

public struct PageControl: UIViewRepresentable {
  
  @Binding public var currentPageIndex: Int
  
  var numberOfPages: Int
  var indicatorColor: Color
  var currentIndicatorColor: Color
  var scale: CGFloat
  
  public init(
    currentPageIndex: Binding<Int>,
    numberOfPages: Int,
    indicatorColor: Color,
    currentIndicatorColor: Color,
    scale: CGFloat = 1
  ) {
    self._currentPageIndex = currentPageIndex
    self.numberOfPages = numberOfPages
    self.indicatorColor = indicatorColor
    self.currentIndicatorColor = currentIndicatorColor
    self.scale = scale
  }
  
  public func makeUIView(context: Context) -> UIPageControl {
    let control = UIPageControl()
    control.numberOfPages = numberOfPages
    control.currentPageIndicatorTintColor = UIColor(currentIndicatorColor)
    control.pageIndicatorTintColor = UIColor(indicatorColor)
    control.transform = CGAffineTransform(scaleX: scale, y: scale)
    control.isUserInteractionEnabled = false
    return control
  }
  
  public func updateUIView(_ uiView: UIPageControl, context: Context) {
    uiView.currentPage = currentPageIndex
  }
}
#endif
