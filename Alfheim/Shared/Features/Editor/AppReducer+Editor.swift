//
//  AppReducer+Editor.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/15.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import ComposableArchitecture

extension AppReducers {
  enum Editor {
    static let reducer = Reducer<AppState.Editor, AppAction.Editor, AppEnvironment.Editor> { state, action, environment in

      struct ValidationId: Hashable {}

      switch action {
      case .new:
        state.reset(.new)
      case .edit(let transaction):
        state.reset(.edit(transaction))
      case let .save(snapshot, mode):
        switch mode {
        case .new:
          return AppEffects.Transaction.create(snapshot: snapshot, context: environment.context)
            .replaceError(with: false)
            .ignoreOutput()
            .eraseToEffect()
            .fireAndForget()
        case .update:
          ()
          //appCommand = AppCommands.UpdateTransactionCommand(transaction: snashot)
        case .delete:
          fatalError("Editor can't delete")
        }
      case .changed(let field):
        switch field {
        case .amount(let value):
          state.amount = value
        case .catemoji(let emoji):
          state.catemoji = emoji
        case .currency(let value):
          state.currency = value
        case .date(let value):
          state.date = value
        case .notes(let value):
          state.notes = value
        case .payment(let payment):
          state.payment = payment
        }
        state.isValid = environment.validator.validate(state: state)
      }
      return .none
    }
//    static func reduce(state: AppState, action: AppAction.Editor) -> (AppState, AppCommand?) {
//      var appState = state
//      var appCommand: AppCommand? = nil
//
//      switch action {
//      case .new:
//        appState.editor.validator.reset(.new)
//      case .edit(let transaction):
//        appState.editor.validator.reset(.edit(transaction))
//      case .save(let snashot, let mode):
//        appState.editor.validator.reset(.new)
//        switch mode {
//        case .new:
//          appCommand = AppCommands.CreateTransactionCommand(transaction: snashot)
//        case .update:
//          appCommand = AppCommands.UpdateTransactionCommand(transaction: snashot)
//        case .delete:
//          fatalError("Editor can't delete")
//        }
//      case .validate(let valid):
//        appState.editor.isValid = valid
//      }
//
//      return (appState, appCommand)
//    }
  }
}
