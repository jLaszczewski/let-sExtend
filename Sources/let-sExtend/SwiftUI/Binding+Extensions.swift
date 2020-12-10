//
//  Binding+Extensions.swift
//  
//
//  Created by Jakub Łaszczewski on 13/11/2020.
//

import SwiftUI

public extension Binding {
  
  /**
   This method alows to handle some action after property wrapper changed.
   
   # Example #
   ```
     struct ContentView: View {
      @State private var rating = 0.0
     
      var body: some View {
        Slider(value: $rating.onChange(sliderChanged))
      }
     
      func sliderChanged(_ value: Double) {
        print("Rating changed to \(value)")
      }
    }
   ```
   
   # Source #
   https://www.hackingwithswift.com/articles/224/common-swiftui-mistakes-and-how-to-fix-them
   */
  func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
    Binding(
      get: { self.wrappedValue },
      set: { newValue in
        self.wrappedValue = newValue
        handler(newValue)
      })
  }
}
