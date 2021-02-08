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
    var selectedTransaction: Alfheim.Transaction?
    var editingTransaction: Bool = false
    var isAccountDetailPresented: Bool = false
    var isSettingsPresented: Bool = false
    var isOnboardingPresented: Bool = false

    var isTransactionListActive = false

    var account: Alfheim.Account
    var period: Period = .yearly

    init(account: Alfheim.Account) {
      self.account = account
    }

    var transactions: [Alfheim.Transaction] {
      account.transactions
    }

    var periodTransactions: [Alfheim.Transaction] {
      let current = Date()
      let startDate: Date
      switch period {
      case .weekly:
        startDate = current.start(of: .week)
      case .monthly:
        startDate = current.start(of: .month)
      case .yearly:
        startDate = current.start(of: .year)
      }

      return transactions
        .filter { $0.date >= startDate }
    }

    var amount: Double {
      periodTransactions
        .map { $0.amount }
        .reduce(0.0, +)
    }

    var amountText: String {
      "\(Alne.Currency(rawValue: Int(account.currency))!.symbol)\(String(format: "%.2f", amount))"
    }
  }
}
