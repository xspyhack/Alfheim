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

  var context: NSManagedObjectContext

  private var disposeBag = Set<AnyCancellable>()

  init(state: AppState = AppState(),
       reducer: AppReducer = AppReducer(),
       moc: NSManagedObjectContext) {
    self.state = state
    self.reducer = reducer
    self.context = moc

    binding()
  }

  private func binding() {
    state.editor.validator.isValid
      .sink { isValid in
        self.dispatch(.editors(.validate(valid: isValid)))
      }
      .store(in: &disposeBag)

    Persistences.Account(context: context)
      .fetchPublisher(withName: Persistences.Account.Buildin.expenses.name)
      .removeDuplicates(by: Alfheim.Account.duplicated)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          print("Load account finished")
        case .failure(let error):
          print("Load account failed: \(error)")
        }
      }, receiveValue: { expenses in
        let tag = expenses.tag!
        let tagit = Tagit(stringLiteral: tag)
        self.dispatch(.accounts(.updateDone(Alne.Account(id: expenses.id.uuidString, name: expenses.name, description: expenses.introduction, tag: tagit, group: .expenses, emoji: expenses.emoji))))
      })
      .store(in: &disposeBag)

    Persistences.Transaction(context: context)
      .loadAll()
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          print("Load account finished")
        case .failure(let error):
          print("Load account failed: \(error)")
        }
      }, receiveValue: { transactions in
        //
        self.dispatch(.transactions(.updated([])))
      })
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
