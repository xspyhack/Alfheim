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
        .loadAll()
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            print("Load transaction failured: \(error)")
          case .finished:
            print("Load transactoin finished")
          }
        }, receiveValue: { transactions in
          print("Transactions \(transactions)")

        })
        .seal(in: token)
    }
  }

  struct UpdateTransactionCommand: AppCommand {
    let transaction: Alne.Transaction

    func execute(in store: AppStore) {
    }
  }
}
