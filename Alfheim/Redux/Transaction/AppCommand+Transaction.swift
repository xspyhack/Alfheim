//
//  AppCommand+Transaction.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/12.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppCommands {
  struct LoadTransactionsCommand: AppCommand {
    func execute(in store: AppStore) {
      let token = SubscriptionToken()
      Persistences.Transaction(context: store.context)
        .fetchAllPublisher()
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            print("Load transaction failured: \(error)")
          case .finished:
            print("Load transactoin finished")
          }
        }, receiveValue: { transactions in
          store.dispatch(.transactions(.loadAllDone(transactions.map { $0.viewModel() })))
        })
        .seal(in: token)
    }
  }

  struct CreateTransactionCommand: AppCommand {
    let transaction: Alne.Transaction

    func execute(in store: AppStore) {
      let persistence = Persistences.Transaction(context: store.context)
      let object = Alfheim.Transaction(context: store.context)
      object.id = UUID()
      object.amount = transaction.amount
      object.currency = Int16(transaction.currency.rawValue)
      object.date = transaction.date
      object.notes = transaction.notes
      object.emoji = transaction.catemoji.emoji
      object.payment = transaction.payment
      object.payee = transaction.payee
      object.number = Int16(transaction.number)

      do {
        try persistence.save()
      } catch {
        print("Update account failed: \(error)")
      }
    }
  }

  struct UpdateTransactionCommand: AppCommand {
    let transaction: Alne.Transaction

    func execute(in store: AppStore) {
      guard let uuid = UUID(uuidString: transaction.id) else {
        return
      }

      let persistence = Persistences.Transaction(context: store.context)
      if let object = persistence.transaction(withID: uuid) {
        object.amount = transaction.amount
        object.currency = Int16(transaction.currency.rawValue)
        object.date = transaction.date
        object.notes = transaction.notes
        object.category = transaction.catemoji.category
        object.emoji = transaction.catemoji.emoji
        object.payment = transaction.payment
        object.payee = transaction.payee
        object.number = Int16(transaction.number)
      } else {
        fatalError("Should not be here!")
      }

      do {
        try Persistences.Transaction(context: store.context).save()
      } catch {
        print("Update account failed: \(error)")
      }
    }
  }
}
