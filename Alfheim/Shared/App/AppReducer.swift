//
//  AppReducer.swift
//  Alfheim
//
//  Created by alex.huo on 2021/2/6.
//  Copyright © 2021 blessingsoft. All rights reserved.
//

import Foundation
import CasePaths
import ComposableArchitecture

enum AppReducers {
  static let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
      switch action {
      case .load:
        return Persistences.Account(context: environment.context!)
          .fetchAllPublisher()
          .replaceError(with: [])
          .map { accounts in
            .loaded(accounts)
          }
          .eraseToEffect()
      case .loaded(let accounts):
        state.overviews = accounts.map { AppState.Overview(account: $0) }
        return .none
      case .cleanup:
        return AppEffects.Account.delete(accounts: state.accounts, environment: environment)
          .replaceError(with: false)
          .ignoreOutput()
          .eraseToEffect()
          .fireAndForget()
      default:
        return .none
      }
    },
    AppReducers.Overview.reducer.forEach(
      state: \AppState.overviews,
      action: /AppAction.overview(index:action:),
      environment: { $0 }
    )
//    AppReducers.Editor.reducer
//      .pullback(
//        state: \.editor,
//        action: /AppAction.editor,
//        environment: { _ in AppEnvironment.Editor(validator: Validator()) }
//      )
  )
}
