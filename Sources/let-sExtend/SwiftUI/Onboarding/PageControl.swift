//
//  PageControl.swift
//  iYoni
//
//  Created by ITgenerator on 03/12/2020.
//

import UIKit
import SwiftUI

struct PageControl: UIViewRepresentable {
  
  @Binding var currentPageIndex: Int
  
  var numberOfPages: Int
  var indicatorColor: Color
  var currentIndicatorColor: Color
  var scale: CGFloat = 1
  
  func makeUIView(context: Context) -> UIPageControl {
    let control = UIPageControl()
    control.numberOfPages = numberOfPages
    control.currentPageIndicatorTintColor = UIColor(currentIndicatorColor)
    control.pageIndicatorTintColor = UIColor(indicatorColor)
    control.transform = CGAffineTransform(scaleX: scale, y: scale)
    control.isUserInteractionEnabled = false
    return control
  }
  
  func updateUIView(_ uiView: UIPageControl, context: Context) {
    uiView.currentPage = currentPageIndex
  }
}
