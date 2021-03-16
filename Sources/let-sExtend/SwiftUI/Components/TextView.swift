//
//  File.swift
//  
//
//  Created by ITgenerator on 21/02/2021.
//

import SwiftUI

#if !os(macOS)
public struct TextView: UIViewRepresentable {
  
  @Binding public var text: String
  @Binding public var isFirstResponder: Bool
  
  private var font: UIFont
  private var textColor: UIColor
  private var tintColor: UIColor
  private var returnKeyType: UIReturnKeyType = .default
  private var autocorrectionType: UITextAutocorrectionType = .default
  private var autocapitalizationType: UITextAutocapitalizationType = .sentences
  private var textFieldBorderStyle: UITextField.BorderStyle = .none
  private var enablesReturnKeyAutomatically: Bool = false
  public var onCommit: (() -> Void)?
  
  public init(
    text: Binding<String>,
    isFirstResponder: Binding<Bool>,
    textAlignment: NSTextAlignment = .left,
    font: UIFont,
    textColor: UIColor,
    tintColor: UIColor,
    returnKeyType: UIReturnKeyType = .default,
    autocorrectionType: UITextAutocorrectionType = .default,
    autocapitalizationType: UITextAutocapitalizationType = .sentences,
    enablesReturnKeyAutomatically: Bool = false,
    onCommit: (() -> Void)? = nil
  ) {
    self._text = text
    self._isFirstResponder = isFirstResponder
    self.font = font
    self.textColor = textColor
    self.tintColor = tintColor
    self.returnKeyType = returnKeyType
    self.autocorrectionType = autocorrectionType
    self.autocapitalizationType = autocapitalizationType
    self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
    self.onCommit = onCommit
  }
  
  public func makeUIView(
    context: Context
  ) -> UITextView {
    let textView = UITextView(frame: .zero)
    textView.delegate = context.coordinator
    textView.font = font
    textView.textColor = textColor
    textView.tintColor = tintColor
    textView.returnKeyType = returnKeyType
    textView.autocorrectionType = autocorrectionType
    textView.autocapitalizationType = autocapitalizationType
    textView.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
    return textView
  }
  
  public func updateUIView(
    _ uiView: UITextView,
    context: Context
  ) {
    uiView.text = text
  }
    
  public func makeCoordinator() -> Coordinator {
    Coordinator(
      text: $text,
      isFirstResponder: $isFirstResponder,
      onCommit: { onCommit?() })
  }
    
  public class Coordinator: NSObject, UITextViewDelegate {
    
    @Binding private var text: String
    @Binding private var isFirstResponder: Bool

    private var onCommit: () -> Void

    init(
      text: Binding<String>,
      isFirstResponder: Binding<Bool>,
      onCommit: @escaping () -> Void
    ) {
      self._text = text
      self._isFirstResponder = isFirstResponder
      self.onCommit = onCommit
    }
    
    public func textViewDidChangeSelection(
      _ textView: UITextView
    ) {
      text = textView.text
    }
    
    public func textView(
      _ textView: UITextView,
      shouldChangeTextIn range: NSRange,
      replacementText text: String
    ) -> Bool {
      isFirstResponder = false
      onCommit()
      return true
    }

    public func textViewDidEndEditing(
      _ textView: UITextView
    ) {
      isFirstResponder = false
    }

    public func textViewDidBeginEditing(
      _ textView: UITextView
    ) {
      isFirstResponder = true
    }
  }
}
#endif
