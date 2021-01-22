//
//  PageViewController.swift
//  
//
//  Created by ITgenerator on 03/12/2020.
//

#if !os(macOS)
import UIKit
import SwiftUI

public struct PageView: UIViewControllerRepresentable {
  
  @Binding public var currentPageIndex: Int
  
  let viewControllers: [UIViewController]
  
  public init(
    currentPageIndex: Binding<Int>,
    viewControllers: [UIViewController]
  ) {
    self._currentPageIndex = currentPageIndex
    self.viewControllers = viewControllers
  }
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  public func makeUIViewController(context: Context) -> UIPageViewController {
    let pageViewController = UIPageViewController(
      transitionStyle: .scroll,
      navigationOrientation: .horizontal)
    pageViewController.dataSource = context.coordinator
    pageViewController.delegate = context.coordinator
    return pageViewController
  }
  
  public func updateUIViewController(
    _ pageViewController: UIPageViewController,
    context: Context
  ) {
    pageViewController.setViewControllers(
      [viewControllers[currentPageIndex]],
      direction: .forward,
      animated: true)
  }
}

public extension PageView {
  
  class Coordinator: NSObject,
                            UIPageViewControllerDataSource,
                            UIPageViewControllerDelegate {
    
    var parent: PageView
    
    init(_ pageViewController: PageView) {
      self.parent = pageViewController
    }
    
    public func pageViewController(
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
    
    public func pageViewController(
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
    
    public func pageViewController(
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

struct PageView_Previews: PreviewProvider {
  
  static var previews: some View {
    PageView(
      currentPageIndex: .constant(1),
      viewControllers: [])
    }
}
#endif
