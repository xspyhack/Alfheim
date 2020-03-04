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
      case .editTransactionDone:
        appState.overview.selectedTransaction = nil
      case .toggleStatistics(let presenting):
        appState.overview.isStatisticsPresented = presenting
      case .toggleAccountDetail(let presenting):
        appState.accountDetail.account = appState.shared.account
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
    case .settings:
      ()
    case .accounts(let subaction):
      switch subaction {
      case .update(let account):
        appState.shared.account = account
        appState.overview.isAccountDetailPresented = false
      }
    @unknown default:
      fatalError("unknown")
    }

    return (appState, appCommand)
  }
}
