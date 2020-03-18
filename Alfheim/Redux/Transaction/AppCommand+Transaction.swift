//
//  AppCommand+Transaction.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/12.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine

extension AppCommands {
  struct LoadTransactionsCommand: AppCommand {
    let filter: AnyPublisher<(Date, Date), Never>
    var token: SubscriptionToken

    func execute(in store: AppStore) {
      filter.setFailureType(to: NSError.self)
        .map {
          Persistences.Transaction(context: store.context)
            .fetchPublisher(from: $0.0, to: $0.1)
        }
        .switchToLatest()
        .map { $0.compactMap { Alne.Transaction($0) } }
        .sink(receiveCompletion: { completion in
          if case .failure(let error) = completion {
            print("error")
          }
          self.token.unseal()
        }, receiveValue: { value in
          store.dispatch(.transactions(.loadAllDone(value)))
        })
        .seal(in: token)
    }
  }

  struct CreateTransactionCommand: AppCommand {
    let transaction: Alne.Transaction

    func execute(in store: AppStore) {
      let persistence = Persistences.Transaction(context: store.context)
      let object = Alfheim.Transaction(context: store.context)
      object.fill(transaction)

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
        object.fill(transaction)
      } else {
        fatalError("Should not be here!")
      }

      do {
        try persistence.save()
      } catch {
        print("Update transaction failed: \(error)")
      }
    }
  }

  struct DeleteTransactionCommand: AppCommand {
    let transactions: [Alne.Transaction]

    func execute(in store: AppStore) {
      guard !transactions.isEmpty else {
        return
      }

      let persistence = Persistences.Transaction(context: store.context)

      for transaction in transactions {
        delete(transaction, persistence: persistence)
      }

      do {
        try persistence.save()
      } catch {
        print("Delete transaction failed: \(error)")
      }
    }

    private func delete(_ transaction: Alne.Transaction, persistence: Persistences.Transaction) {
      guard let uuid = UUID(uuidString: transaction.id) else {
        return
      }

      guard let object = persistence.transaction(withID: uuid) else {
        fatalError("Should not be here!")
      }
      object.fill(transaction)
      persistence.delete(object)
    }
  }
}
