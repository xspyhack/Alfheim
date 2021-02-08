//
//  AppReducer.swift
//  Alfheim
//
//  Created by alex.huo on 2021/2/6.
//  Copyright © 2021 blessingsoft. All rights reserved.
//

import Foundation
import CasePaths

enum AppReducers {
  static let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
      switch action {
      case .load:
        return Persistences.Account(context: environment.context!)
          .fetchAllPublisher()
          .replaceError(with: [])
          .map { accounts in
            AppAction.account(.loaded(accounts))
          }
          .eraseToEffect()
      default:
        return .none
      }
    },
    AppReducers.Account.reducer.lift(
      state: \.account,
      action: /AppAction.account,
      environment: { $0 })
  )
}
