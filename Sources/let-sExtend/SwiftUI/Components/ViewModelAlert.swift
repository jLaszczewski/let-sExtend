//
//  ViewModelAlert.swift
//
//
//  Created by Jakub Łaszczewski on 01/12/2020.
//

import SwiftUI

public struct ViewModelAlert: Identifiable {
  
  private enum Kind {
    case dismiss(ViewModelAlert.Button?)
    case withActions(
          primaryAction: Button,
          secondaryAction: Button)
  }
  
  public let id = UUID()
  
  private let title: String
  private let message: String?
  private let kind: Kind
  
  public init(
    title: String,
    message: String? = nil,
    dismissButton: Button? = nil
  ) {
    self.title = title
    self.message = message
    self.kind = .dismiss(dismissButton)
  }
  
  public init(
    title: String,
    message: String? = nil,
    primaryButton: Button,
    secondaryButton: Button
  ) {
    self.title = title
    self.message = message
    self.kind = .withActions(
      primaryAction: primaryButton,
      secondaryAction: secondaryButton)
  }
  
  public var ui: Alert {
    switch kind {
    case let .dismiss(button):
      return Alert(
        title: Text(title),
        message: Text(message),
        dismissButton: button?.ui)
    case let .withActions(primaryAction, secondaryAction):
      return Alert(
        title: Text(title),
        message: Text(message),
        primaryButton: primaryAction.ui,
        secondaryButton: secondaryAction.ui)
    }
  }
}

// MARK: - Button
public extension ViewModelAlert {
  
  struct Button {
    
    private enum Style {
      case `default`
      case `cancel`
      case `destructive`
    }
    
    private let label: String?
    private let action: (() -> Void)?
    private let style: Style
    
    private init(
      label: String? = nil,
      action: (() -> Void)?,
      style: Style
    ) {
      self.label = label
      self.action = action
      self.style = style
    }
    
    public static func `default`(
      _ label: String,
      action: (() -> Void)? = {}
    ) -> Button {
      Button(label: label, action: action, style: .default)
    }
    
    public static func cancel(
      _ label: String,
      action: (() -> Void)? = {}
    ) -> Button {
      Button(label: label, action: action, style: .cancel)
    }
    
    public static func cancel(
      _ action: (() -> Void)? = {}
    ) -> Button {
      Button(action: action, style: .cancel)
    }
    
    public static func destructive(
      _ label: String,
      action: (() -> Void)? = {}
    ) -> Button {
      Button(label: label, action: action, style: .destructive)
    }
    
    public var ui: Alert.Button {
      switch style {
      case .default:
        return .default(Text(label!), action: action)
      case .cancel:
        if let label = label {
          return .cancel(Text(label), action: action)
        } else {
          return .cancel(action)
        }
      case .destructive:
        return .destructive(Text(label!), action: action)
      }
    }
  }
}
