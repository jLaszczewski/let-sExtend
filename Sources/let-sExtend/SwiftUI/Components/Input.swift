//
//  Input.swift
// 
//
//  Created by Jakub Łaszczewski on 27/11/2020.
//

#if !os(macOS)
import Combine
import SwiftUI

public struct Input: UIViewRepresentable {
  
  @Binding public var text: String
  @Binding public var isFirstResponder: Bool
  @Binding public var isSecure: Bool
  
  private var placeholder: String
  private var textAlignment: NSTextAlignment = .left
  private var font: UIFont
  private var textColor: UIColor
  private var tintColor: UIColor
  private var keyboardType: UIKeyboardType = .default
  private var returnKeyType: UIReturnKeyType = .default
  private var textContentType: UITextContentType?
  private var autocorrectionType: UITextAutocorrectionType = .default
  private var autocapitalizationType: UITextAutocapitalizationType = .sentences
  private var textFieldBorderStyle: UITextField.BorderStyle = .none
  private var enablesReturnKeyAutomatically: Bool = false
  
  private var shouldAllowTextChangeHandler: ((String?) -> Bool)?
  private var replaceInputTextHandler: ((String?) -> String?)?
  public var onCommit: (() -> Void)?
  
  public init(
    text: Binding<String>,
    isFirstResponder: Binding<Bool>,
    isSecure: Binding<Bool>,
    placeholder: String,
    textAlignment: NSTextAlignment = .left,
    font: UIFont,
    textColor: UIColor,
    tintColor: UIColor,
    keyboardType: UIKeyboardType = .default,
    returnKeyType: UIReturnKeyType = .default,
    textContentType: UITextContentType? = nil,
    autocorrectionType: UITextAutocorrectionType = .default,
    autocapitalizationType: UITextAutocapitalizationType = .sentences,
    textFieldBorderStyle: UITextField.BorderStyle = .none,
    enablesReturnKeyAutomatically: Bool = false,
    shouldAllowTextChangeHandler: ((String?) -> Bool)? = nil,
    replaceInputTextHandler: ((String?) -> String?)? = nil,
    onCommit: (() -> Void)? = nil
  ) {
    self._text = text
    self._isFirstResponder = isFirstResponder
    self._isSecure = isSecure
    self.placeholder = placeholder
    self.textAlignment = textAlignment
    self.font = font
    self.textColor = textColor
    self.tintColor = tintColor
    self.keyboardType = keyboardType
    self.returnKeyType = returnKeyType
    self.textContentType = textContentType
    self.autocorrectionType = autocorrectionType
    self.autocapitalizationType = autocapitalizationType
    self.textFieldBorderStyle = textFieldBorderStyle
    self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
    
    self.shouldAllowTextChangeHandler = shouldAllowTextChangeHandler
    self.replaceInputTextHandler = replaceInputTextHandler
    self.onCommit = onCommit
  }
  
  public func makeUIView(
    context: UIViewRepresentableContext<Input>
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
  
  public func makeCoordinator() -> Input.Coordinator {
    return Coordinator(
      text: $text,
      isFirstResponder: $isFirstResponder,
      shouldAllowTextChangeHandler: shouldAllowTextChangeHandler,
      replaceInputTextHandler: replaceInputTextHandler,
      onCommit: onCommit)
  }
  
  public func updateUIView(
    _ uiView: UITextField,
    context: UIViewRepresentableContext<Input>
  ) {
    uiView.setContentCompressionResistancePriority(
      .defaultLow,
      for: .horizontal)
    uiView.text = text
    uiView.isSecureTextEntry = isSecure
  }
}

public extension Input {
  
  class Coordinator: NSObject, UITextFieldDelegate {
    
    @Binding var text: String
    @Binding var isFirstResponder: Bool
    
    var shouldAllowTextChangeHandler: ((String?) -> Bool)?
    var replaceInputTextHandler: ((String?) -> String?)?
    var onCommit: (() -> Void)?
    
    init(
      text: Binding<String>,
      isFirstResponder: Binding<Bool>,
      shouldAllowTextChangeHandler: ((String?) -> Bool)?,
      replaceInputTextHandler: ((String?) -> String?)?,
      onCommit: (() -> Void)?
    ) {
      _text = text
      _isFirstResponder = isFirstResponder
      
      self.shouldAllowTextChangeHandler = shouldAllowTextChangeHandler
      self.replaceInputTextHandler = replaceInputTextHandler
      self.onCommit = onCommit
    }
    
    public func textField(
      _ textField: UITextField,
      shouldChangeCharactersIn range: NSRange,
      replacementString string: String
    ) -> Bool {
      let nsString = textField.text as NSString?
      let newText = nsString?.replacingCharacters(
        in: range,
        with: string
      )
      
      if let replaceInputTextHandler = replaceInputTextHandler {
        let replacedText = replaceInputTextHandler(newText)
        textField.text = shouldAllowTextChangeHandler?(replacedText) == false
          ? textField.text
          : replacedText
        return false
      }
      
      return shouldAllowTextChangeHandler?(newText) ?? true
    }
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
      text = textField.text ?? ""
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      isFirstResponder = false
      onCommit?()
      return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
      isFirstResponder = false
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
      isFirstResponder = true
    }
  }
}
#endif
