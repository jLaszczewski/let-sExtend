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
  
  private var shouldAllowTextChangeHandler: ((String?) -> Bool)?
  private var replaceInputTextHandler: ((String?) -> String?)?
  
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
    shouldAllowTextChangeHandler: ((String?) -> Bool)? = nil,
    replaceInputTextHandler: ((String?) -> String?)? = nil
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
    
    self.shouldAllowTextChangeHandler = shouldAllowTextChangeHandler
    self.replaceInputTextHandler = replaceInputTextHandler
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
      shouldAllowTextChangeHandler: shouldAllowTextChangeHandler,
      replaceInputTextHandler: replaceInputTextHandler)
  }
    
  public class Coordinator: NSObject, UITextViewDelegate {
    
    @Binding private var text: String
    @Binding private var isFirstResponder: Bool

    var shouldAllowTextChangeHandler: ((String?) -> Bool)?
    var replaceInputTextHandler: ((String?) -> String?)?

    init(
      text: Binding<String>,
      isFirstResponder: Binding<Bool>,
      shouldAllowTextChangeHandler: ((String?) -> Bool)?,
      replaceInputTextHandler: ((String?) -> String?)?
    ) {
      self._text = text
      self._isFirstResponder = isFirstResponder
      
      self.shouldAllowTextChangeHandler = shouldAllowTextChangeHandler
      self.replaceInputTextHandler = replaceInputTextHandler
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
      let nsString = textView.text as NSString?
      let newText = nsString?.replacingCharacters(
        in: range,
        with: text
      )
      
      if let replaceInputTextHandler = replaceInputTextHandler {
        let replacedText = replaceInputTextHandler(newText)
        textView.text = shouldAllowTextChangeHandler?(replacedText) == false
          ? textView.text
          : replacedText
        return false
      }
      
      return shouldAllowTextChangeHandler?(newText) ?? true
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
