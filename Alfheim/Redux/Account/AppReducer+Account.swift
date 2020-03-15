//
//  AppReducer+Account.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/12.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppReducers {
  enum Account {
    static func reduce(state: AppState, action: AppAction.Accounts) -> (AppState, AppCommand?) {
      var appState = state
      var appCommand: AppCommand? = nil

      switch action {
      case .update(let account):
        appState.overview.isAccountDetailPresented = false
        appCommand = AppCommands.UpdateAccountCommand(account: account)
      case .updateDone(let account):
        appState.shared.account = account
      }

      return (appState, appCommand)
    }
  }
}
