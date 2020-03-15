//
//  AppState.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine

struct AppState {
  var shared: Shared
  var overview = Overview()
  var transactions = TransactionList()
  var editor = Editor()
  var settings = Settings()
  // shared global state

  var accountDetail: AccountDetail

  init() {
    let account = Alne.Accounts.expenses
    let transactions = Alne.Transactions.samples()
    shared = Shared(account: account, allTransactions: transactions)
    accountDetail = AccountDetail(account: account)
  }
}

extension AppState {
  /// Transaction period
  enum Period {
    case weekly
    case montly
    case yearly

    var display: String {
      switch self {
      case .weekly:
        return "this week"
      case .montly:
        return "this month"
      case .yearly:
        return "this year"
      }
    }
  }

  enum Sorting: CaseIterable {
    case date
    case currency
  }
}

extension AppState {
  /// Shared global state
  struct Shared {
    var account: Alne.Account
    /// this should be latest selected period
    var period: Period = .montly
    /// this should be latest selected sorting
    var sorting: Sorting = .date

    var allTransactions: [Alne.Transaction]

    var periodTransactions: [Alne.Transaction] {
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

      return allTransactions
        .filter { $0.date >= startDate }
    }

    var displayTransactions: [Alne.Transaction] {
      let sortBy: (Alne.Transaction, Alne.Transaction) -> Bool
      switch sorting {
      case .date:
        sortBy = { $0.date > $1.date }
      case .currency:
        sortBy = { $0.currency.rawValue < $1.currency.rawValue }
      }

      return periodTransactions
        .sorted(by: sortBy)
    }

    var amount: Double {
      periodTransactions
        .map { $0.amount }
        .reduce(0.0, +)
    }

    var amountText: String {
      "\(account.currency.symbol)\(amount)"
    }

    var categorizedAmount: [String: Double] {
      displayTransactions
        .grouped { $0.catemoji.category }
        .mapValues { $0.reduce(0, { $0 + $1.amount }) }
    }
  }
}
