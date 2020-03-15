//
//  AppReducer+Overview.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/15.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppReducers {
  enum Overview {
    static func reduce(state: AppState, action: AppAction.Overviews) -> (AppState, AppCommand?) {
      var appState = state
      let appCommand: AppCommand? = nil

      switch action {
      case .toggleNewTransaction(let presenting):
        appState.overview.isEditorPresented = presenting
        appState.editor.isValid = false // Important! need set here
        appState.editor.validator.reset(.new)
      case .editTransaction(let transaction):
        appState.overview.selectedTransaction = transaction
        appState.overview.editingTransaction = true
        appState.editor.isValid = true // Important! need set here
        appState.editor.validator.reset(.edit(transaction))
      case .editTransactionDone:
        appState.overview.selectedTransaction = nil
        appState.overview.editingTransaction = false
        appState.editor.isValid = false // Important! need set here
        appState.editor.validator.reset(.new)
      case .toggleStatistics(let presenting):
        appState.overview.isStatisticsPresented = presenting
      case .toggleAccountDetail(let presenting):
        appState.accountDetail.account = appState.shared.account // save draft
        appState.overview.isAccountDetailPresented = presenting
      case .switchPeriod:
        switch state.shared.period {
        case .weekly:
          appState.shared.period = .montly
        case .montly:
          appState.shared.period = .yearly
        case .yearly:
          appState.shared.period = .weekly
        }
      }

      return (appState, appCommand)
    }
  }
}
