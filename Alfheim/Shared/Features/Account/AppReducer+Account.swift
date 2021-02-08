//
//  AppReducer+Account.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/12.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine

extension AppReducers {
  enum Account {
    static let reducer = Reducer<AppState.Account, AppAction.Account, AppEnvironment> { state, action, environment in
      switch action {
      case .loaded(let accounts):
        state.accounts = accounts
      case .cleanup:
        return AppEffects.Account.delete(accounts: state.accounts, environment: environment)
          .replaceError(with: false)
          .ignoreOutput()
          .eraseToEffect()
          .forget()
      }
      return .none
    }
  }
}
