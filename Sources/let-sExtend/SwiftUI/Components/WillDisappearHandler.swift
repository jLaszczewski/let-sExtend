//
//  WillDisappearHandler.swift
//  
//
//  Created by ITgenerator on 24/02/2021.
//

#if !os(macOS)
import SwiftUI

public struct WillDisappearHandler: UIViewControllerRepresentable {
  
  public let onWillDisappear: () -> Void
  
  public func makeCoordinator() -> WillDisappearHandler.Coordinator {
    Coordinator(onWillDisappear: onWillDisappear)
  }
  
  public func makeUIViewController(
    context: UIViewControllerRepresentableContext<WillDisappearHandler>
  ) -> UIViewController {
    context.coordinator
  }
   
  public func updateUIViewController(
    _ uiViewController: UIViewController,
    context: UIViewControllerRepresentableContext<WillDisappearHandler>
  ) {
  }
  
  public class Coordinator: UIViewController {
    
    let onWillDisappear: () -> Void
        
    init(onWillDisappear: @escaping () -> Void) {
      self.onWillDisappear = onWillDisappear
      super.init(nibName: nil, bundle: nil)
    }
     
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
     
    public override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      onWillDisappear()
    }
  }
}

public struct WillDisappearModifier: ViewModifier {
  
  let callback: () -> Void
    
  public func body(content: Content) -> some View {
    content
      .background(WillDisappearHandler(onWillDisappear: callback))
  }
}

public extension View {
  
  func onWillDisappear(
    with animation: Animation? = nil,
    _ perform: @escaping () -> Void
  ) -> some View {
    withAnimation(animation) {
      modifier(WillDisappearModifier(callback: perform))
    }
  }
}

#endif
