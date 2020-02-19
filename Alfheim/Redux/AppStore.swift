//
//  Store.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

class AppStore: ObservableObject {
  @Published var state: AppState

  init(state: AppState = AppState()) {
    self.state = state
  }

  func dispatch(_ action: AppAction) {
    print("[ACTION]: \(action)")
    let result = AppStore.reduce(state: state, action: action)
    state = result.0
    if let command = result.1 {
        print("[COMMAND]: \(command)")
        command.execute(in: self)
    }
  }
}

extension AppStore {
  static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
    var appState = state
    var appCommand: AppCommand? = nil

    switch action {
    case .overview:
      ()
    case .settings:
      ()
    case .account:
      ()
    @unknown default:
      fatalError("unknown")
    }

    return (appState, appCommand)
  }
}
