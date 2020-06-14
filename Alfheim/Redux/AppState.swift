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
  var payment = Payment()
  var catemoji = Catemoji()
  var statistics: Statistics
  // shared global state

  var accountDetail: AccountDetail

  init() {
    let account = Alne.Accounts.expenses
    shared = Shared(account: account, allPayments: [], allTransactions: [])
    accountDetail = AccountDetail(account: account)
    statistics = Statistics(account: account)
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

    var allPayments: [Alfheim.Payment]

    var allTransactions: [Alfheim.Transaction]

    var periodTransactions: [Alfheim.Transaction] {
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

    var displayTransactions: [TransactionViewModel] {
      let sortBy: (Alfheim.Transaction, Alfheim.Transaction) -> Bool
      switch sorting {
      case .date:
        sortBy = { $0.date > $1.date }
      case .currency:
        sortBy = { $0.currency < $1.currency }
      }

      return periodTransactions
        .sorted(by: sortBy)
        .map { TransactionViewModel(transaction: $0, tag: account.tag) }
    }

    var amount: Double {
      periodTransactions
        .map { $0.amount }
        .reduce(0.0, +)
    }

    var amountText: String {
      "\(account.currency.symbol)\(String(format: "%.2f", amount))"
    }

    var timeRange: Range<Date> {
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

      return startDate..<current
    }
  }
}

extension Date: Strideable {
  public func distance(to other: Date) -> TimeInterval {
    return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
  }

  public func advanced(by n: TimeInterval) -> Date {
    return self + n
  }
}
