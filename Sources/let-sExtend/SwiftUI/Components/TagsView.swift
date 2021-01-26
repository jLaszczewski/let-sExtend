//
//  TagsView.swift
//  
//
//  Created by ITgenerator on 26/01/2021.
//

import SwiftUI

public struct TagsView<Model, V>: View where Model: Hashable, V: View {
    
  public typealias ViewGenerator = (Model) -> V
    
  public enum Mode {
    
    case scrollable
    case vstack
  }
  
  @State private var totalHeight: CGFloat
  
  private let mode: Mode
  private let models: [Model]
  private let viewGenerator: ViewGenerator
  private let horizontalSpacing: CGFloat
  private let verticalSpacing: CGFloat
  
  public init(
    mode: Mode,
    models: [Model],
    viewGenerator: @escaping ViewGenerator,
    horizontalSpacing: CGFloat,
    verticalSpacing: CGFloat
  ) {
    self.mode = mode
    self.models = models
    self.viewGenerator = viewGenerator
    self.horizontalSpacing = horizontalSpacing
    self.verticalSpacing = verticalSpacing
    self._totalHeight = State(initialValue: (mode == .scrollable) ? .zero : .infinity)
  }
  
  public var body: some View {
    let stack = VStack {
      GeometryReader { geometry in
        generateContent(in: geometry)
      }
    }
    
    return Group {
      if mode == .scrollable {
        stack.frame(height: totalHeight)
      } else {
        stack.frame(maxHeight: totalHeight)
      }
    }
  }
  
  private func generateContent(in geometry: GeometryProxy) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    
    return ZStack(alignment: .topLeading) {
      ForEach(models, id: \.self) { models in
        viewGenerator(models)
          .alignmentGuide(.leading, computeValue: { dimension in
            if (abs(width - dimension.width - horizontalSpacing) > geometry.size.width) {
              width = 0
              height -= dimension.height + verticalSpacing
            }
            
            let result = width
            if models == self.models.last! {
              width = 0
            } else {
              width -= dimension.width + horizontalSpacing
            }
            
            return result
          })
          .alignmentGuide(.top, computeValue: { dimension in
            let result = height
                        
            if models == self.models.last! {
              height = 0
            }
                        
            return result
          })
      }
    }
    .background(viewHeightReader($totalHeight))
  }
  
  private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
    return GeometryReader { geometry -> Color in
      let rect = geometry.frame(in: .local)
      
      DispatchQueue.main.async {
        binding.wrappedValue = rect.size.height
      }
            
      return .clear
    }
  }
}
