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

    func displayTransactions(from start: Date, to end: Date) -> [Alne.Transaction] {
      return transactions
        .sorted(by: { $0.date > $1.date })
        .filter { $0.date <= end && $0.date >= start }
    }
  }
}
