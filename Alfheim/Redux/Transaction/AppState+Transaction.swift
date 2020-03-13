//
//  AppState+Transaction.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/12.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import CoreData
import Combine

extension AppState {
  /// Transaction list view state
  struct TransactionList {
    var transactions: [Alne.Transaction] = []

    var isLoading = false

    class Listener {
      var token: AnyCancellable?

      func start(_ context: NSManagedObjectContext) {
        token = Persistences.Transaction(context: context)
          .fetchAllPublisher()
          .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
              print("Load transaction failured: \(error)")
            case .finished:
              print("Load transactoin finished")
            }
          }, receiveValue: { transactions in
          })
      }

      func stop() {
        token = nil
      }
    }
  }
}
