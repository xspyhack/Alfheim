//
//  Reducer.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2021/2/4.
//  Copyright © 2021 blessingsoft. All rights reserved.
//

import Foundation
import Combine
import CasePaths

struct Reducer<State, Action, Environment> {
  let reduce: (inout State, Action, Environment) -> Effect<Action, Never>

  func callAsFunction(
    _ state: inout State,
    _ action: Action,
    _ environment: Environment
  ) -> Effect<Action, Never> {
    reduce(&state, action, environment)
  }

  func lift<TargetState, TargetAction, TargetEnvironment>(
    state liftedState: WritableKeyPath<TargetState, State>,
    action liftedAction: CasePath<TargetAction, Action>,
    environment liftedEnvironment: @escaping (TargetEnvironment) -> Environment
  ) -> Reducer<TargetState, TargetAction, TargetEnvironment> {
    Reducer<TargetState, TargetAction, TargetEnvironment> { sourceState, sourceAction, sourceEnvironment in
      guard let action = liftedAction.extract(from: sourceAction) else {
        return .none
      }
      return self.reduce(
        &sourceState[keyPath: liftedState],
        action,
        liftedEnvironment(sourceEnvironment)
      )
      .map(liftedAction.embed)
      .eraseToEffect()
    }
  }

  func combined(with other: Reducer) -> Reducer {
    Reducer.combine(self, other)
  }

  static func combine(_ reducers: Reducer...) -> Reducer {
    combine(reducers)
  }

  static func combine(_ reducers: [Reducer]) -> Reducer {
    Reducer { state, action, environment in
      let effects = reducers.map { $0.reduce(&state, action, environment) }
      return Publishers.MergeMany(effects).eraseToAnyPublisher()
    }
  }
}
