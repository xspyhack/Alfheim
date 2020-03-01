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
    case .overview(let subaction):
      switch subaction {
      case .toggleNewTransaction(let presenting):
        appState.overview.viewState.isEditorPresented = presenting
      case .editTransaction(let transaction):
        appState.overview.viewState.selectedTransaction = transaction
      case .editTransactionDone:
        appState.overview.viewState.selectedTransaction = nil
      case .toggleStatistics(let presenting):
        appState.overview.viewState.isStatisticsPresented = presenting
      case .toggleAccountDetail(let presenting):
        appState.overview.viewState.isAccountDetailPresented = presenting
      case .switchPeriod:
        switch state.overview.period {
        case .weekly:
          appState.overview.period = .montly
        case .montly:
          appState.overview.period = .yearly
        case .yearly:
          appState.overview.period = .weekly
        }
      }
    case .settings:
      ()
    case .account(let subaction):
      switch subaction {
      case .toggleTagitSelection(let tag):
        appState.account.tag = tag
        appState.overview.account.tag = tag
      }
    @unknown default:
      fatalError("unknown")
    }

    return (appState, appCommand)
  }
}
