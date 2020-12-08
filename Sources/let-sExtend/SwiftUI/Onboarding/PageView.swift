//
//  PageViewController.swift
//  iYoni
//
//  Created by ITgenerator on 03/12/2020.
//

import UIKit
import SwiftUI

struct PageView: UIViewControllerRepresentable {
  
  @Binding var currentPageIndex: Int
  
  let viewControllers: [UIViewController]
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIViewController(context: Context) -> UIPageViewController {
    let pageViewController = UIPageViewController(
      transitionStyle: .scroll,
      navigationOrientation: .horizontal)
    pageViewController.dataSource = context.coordinator
    pageViewController.delegate = context.coordinator
    return pageViewController
  }
  
  func updateUIViewController(
    _ pageViewController: UIPageViewController,
    context: Context
  ) {
    pageViewController.setViewControllers(
      [viewControllers[currentPageIndex]],
      direction: .forward,
      animated: true)
  }
  
  class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var parent: PageView

    init(_ pageViewController: PageView) {
      self.parent = pageViewController
    }
    
    func pageViewController(
      _ pageViewController: UIPageViewController,
      viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
      guard
        let index = parent.viewControllers.firstIndex(of: viewController),
        index != 0 else {
        return nil
      }
      
      return parent.viewControllers[index - 1]
    }
            
    func pageViewController(
      _ pageViewController: UIPageViewController,
      viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
      guard
        let index = parent.viewControllers.firstIndex(of: viewController),
        index < parent.viewControllers.count - 1 else {
        return nil
      }
      
      return parent.viewControllers[index + 1]
    }
    
    func pageViewController(
      _ pageViewController: UIPageViewController,
      didFinishAnimating finished: Bool,
      previousViewControllers: [UIViewController],
      transitionCompleted completed: Bool
    ) {
      if completed,
         let visibleViewController = pageViewController.viewControllers?.first,
         let index = parent.viewControllers.firstIndex(of: visibleViewController) {
        parent.currentPageIndex = index
      }
    }
  }
}
