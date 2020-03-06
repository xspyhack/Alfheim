//
//  Store.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine

class AppStore: ObservableObject {
  @Published var state: AppState
  private let reducer: AppReducer

  private var disposeBag = Set<AnyCancellable>()

  init(state: AppState = AppState(), reducer: AppReducer = AppReducer()) {
    self.state = state
    self.reducer = reducer

    binding()
  }

  private func binding() {
    state.editor.validator.isValid
      .sink { isValid in
        self.dispatch(.editors(.validate(valid: isValid)))
      }
      .store(in: &disposeBag)
  }

  func dispatch(_ action: AppAction) {
    print("[ACTION]: \(action)")
    let result = reducer.reduce(state: state, action: action)
    state = result.0
    if let command = result.1 {
      print("[COMMAND]: \(command)")
      command.execute(in: self)
    }
  }
}
