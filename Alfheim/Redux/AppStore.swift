//
//  Store.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine
import CoreData

class AppStore: ObservableObject {
  @Published var state: AppState
  private let reducer: AppReducer

  var managedObjectContext: NSManagedObjectContext

  private var disposeBag = Set<AnyCancellable>()

  init(state: AppState = AppState(),
       reducer: AppReducer = AppReducer(),
       moc: NSManagedObjectContext) {
    self.state = state
    self.reducer = reducer
    self.managedObjectContext = moc

    binding()
  }

  private func binding() {
    state.editor.validator.isValid
      .sink { isValid in
        self.dispatch(.editors(.validate(valid: isValid)))
      }
      .store(in: &disposeBag)

    Persistences.Account(context: managedObjectContext)
      .loadAll()
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          print("Load account finished")
        case .failure(let error):
          print("Load account failed: \(error)")
        }
      }, receiveValue: { accounts in
        guard let account = accounts.first else {
          return
        }
        self.dispatch(.accounts(.update(Alne.Account(id: account.id.uuidString, name: account.name, description: account.introduction, tag: .alfheim, group: .expenses, emoji: nil))))
      })
      .store(in: &disposeBag)

    let account = Account(context: managedObjectContext)
    account.id = UUID()
    account.name = "Expense"
    account.introduction = "Test"

    do {
      try managedObjectContext.save()
    } catch {
      print("save error: \(error)")
    }
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
