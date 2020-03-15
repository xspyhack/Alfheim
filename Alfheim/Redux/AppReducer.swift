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
    switch action {
    case .overviews(let subaction):
      return AppReducers.Overview.reduce(state: state, action: subaction)
    case .editors(let subaction):
      return AppReducers.Editor.reduce(state: state, action: subaction)
    case .settings(let subaction):
      return AppReducers.Settings.reduce(state: state, action: subaction)
    case .accounts(let subaction):
      return AppReducers.Account.reduce(state: state, action: subaction)
    case .transactions(let subaction):
      return AppReducers.Transactions.reduce(state: state, action: subaction)
    }
  }
}

enum AppReducers {
}
