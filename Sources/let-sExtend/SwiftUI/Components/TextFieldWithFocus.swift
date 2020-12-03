//
//  TextFieldWithFocus.swift
//  iYoni
//
//  Created by Jakub Łaszczewski on 27/11/2020.
//

import SwiftUI

import Combine
import SwiftUI

public struct TextFieldWithFocus: UIViewRepresentable {
  
  public class Coordinator: NSObject, UITextFieldDelegate {
    
    @Binding var text: String
    @Binding var isFirstResponder: Bool
        
    var onCommit: () -> Void
    
    init(
      text: Binding<String>,
      isFirstResponder: Binding<Bool>,
      onCommit: @escaping () -> Void
    ) {
      _text = text
      _isFirstResponder = isFirstResponder
      self.onCommit = onCommit
    }
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
      text = textField.text ?? ""
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      isFirstResponder = false
      onCommit()
      return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
      isFirstResponder = false
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
      isFirstResponder = true
    }
  }
  
  @Binding var text: String
  @Binding var isFirstResponder: Bool
  @Binding var isSecure: Bool
  
  var placeholder: String
  var textAlignment: NSTextAlignment = .left
  var font: UIFont
  var textColor: UIColor
  var tintColor: UIColor
  var keyboardType: UIKeyboardType = .default
  var returnKeyType: UIReturnKeyType = .default
  var textContentType: UITextContentType?
  var autocorrectionType: UITextAutocorrectionType = .default
  var autocapitalizationType: UITextAutocapitalizationType = .sentences
  var textFieldBorderStyle: UITextField.BorderStyle = .none
  var enablesReturnKeyAutomatically: Bool = false
  
  var onCommit: (() -> Void)?
  
  public func makeUIView(
    context: UIViewRepresentableContext<TextFieldWithFocus>
  ) -> UITextField {
    let textField = UITextField(frame: .zero)
    textField.delegate = context.coordinator
    textField.placeholder = NSLocalizedString(placeholder, comment: "")
    textField.font = font
    textField.textColor = textColor
    textField.tintColor = tintColor
    textField.textAlignment = textAlignment
    textField.keyboardType = keyboardType
    textField.returnKeyType = returnKeyType
    textField.autocorrectionType = autocorrectionType
    textField.autocapitalizationType = autocapitalizationType
    textField.textContentType = textContentType
    textField.borderStyle = textFieldBorderStyle
    textField.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
    
    return textField
  }
  
  public func makeCoordinator() -> TextFieldWithFocus.Coordinator {
    return Coordinator(
      text: $text,
      isFirstResponder: $isFirstResponder,
      onCommit: {
      self.onCommit?()
    })
  }
  
  public func updateUIView(
    _ uiView: UITextField,
    context: UIViewRepresentableContext<TextFieldWithFocus>
  ) {
    uiView.text = text
    uiView.isSecureTextEntry = isSecure
  }
}
