//
//  AppReducer+Setting.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/15.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppReducers {
  enum Settings {
    static func reduce(state: AppState, action: AppAction.Settings) -> (AppState, AppCommand?) {
      var appState = state
      let appCommand: AppCommand? = nil

      switch action {
      case .togglePayment:
        appState.settings.isPaymentEnabled.toggle()
      }

      return (appState, appCommand)
    }
  }
}
