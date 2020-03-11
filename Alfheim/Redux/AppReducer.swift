//
//  Reducer.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

struct AppReducer {
  func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
    var appState = state
    var appCommand: AppCommand? = nil

    switch action {
    case .overviews(let subaction):
      switch subaction {
      case .toggleNewTransaction(let presenting):
        appState.overview.isEditorPresented = presenting
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
    case .editors(let subaction):
      switch subaction {
      case .new:
        appState.editor.validator.reset(.new)
      case .edit(let transaction):
        appState.editor.validator.reset(.edit(transaction))
      case .save(let transaction):
        if let index = state.shared.allTransactions.firstIndex(where: { $0.id == transaction.id }) {
          appState.shared.allTransactions[index] = transaction
        } else {
          appState.shared.allTransactions.append(transaction)
        }
        appState.editor.validator.reset(.new)
      case .validate(let valid):
        appState.editor.isValid = valid
      }
    case .settings(let subaction):
      switch subaction {
      case .togglePayment:
        appState.settings.isPaymentEnabled.toggle()
      }
    case .accounts(let subaction):
      switch subaction {
      case .update(let account):
        //appState.shared.account = account
        appState.overview.isAccountDetailPresented = false
        appCommand = AppCommands.UpdateAccountCommand(account: account)
      case .updateDone(let account):
        appState.shared.account = account
      }
    }

    return (appState, appCommand)
  }
}
