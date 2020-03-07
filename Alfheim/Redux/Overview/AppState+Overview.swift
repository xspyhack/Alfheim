//
//  AppState+Overview.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/3/7.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppState {
  /// Overview view state
  struct Overview {
    var isEditorPresented: Bool = false
    var isStatisticsPresented: Bool = false
    var selectedTransaction: Transaction?
    var editingTransaction: Bool = false
    var isAccountDetailPresented: Bool = false

    var transactions: [Transaction] {
      Alne.Transactions.samples()
    }

    func displayTransactions(with period: Period, sorting: Sorting) -> [Transaction] {
      let current = Date()
      let startDate: Date
      switch period {
      case .weekly:
        startDate = current.start(of: .week)
      case .montly:
        startDate = current.start(of: .month)
      case .yearly:
        startDate = current.start(of: .year)
      }

      let sortBy: (Transaction, Transaction) -> Bool
      switch sorting {
      case .date:
        sortBy = { $0.date > $1.date }
      case .currency:
        sortBy = { $0.currency.rawValue < $1.currency.rawValue }
      }

      return transactions
        .filter { $0.date >= startDate }
        .sorted(by: sortBy)
    }
  }
}
