//
//  AppReducer+Editor.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/15.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppReducers {
  enum Editor {
    static func reduce(state: AppState, action: AppAction.Editors) -> (AppState, AppCommand?) {
      var appState = state
      var appCommand: AppCommand? = nil

      switch action {
      case .new:
        appState.editor.validator.reset(.new)
      case .edit(let transaction):
        appState.editor.validator.reset(.edit(transaction))
      case .save(let transaction, let mode):
        appState.editor.validator.reset(.new)
        switch mode {
        case .new:
          appCommand = AppCommands.CreateTransactionCommand(transaction: transaction)
        case .update:
          appCommand = AppCommands.UpdateTransactionCommand(transaction: transaction)
        case .delete:
          fatalError("Editor can't delete")
        }
      case .validate(let valid):
        appState.editor.isValid = valid
      }

      return (appState, appCommand)
    }
  }
}
