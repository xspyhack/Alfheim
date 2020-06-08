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
  // shared global state

  var accountDetail: AccountDetail

  init() {
    let account = Alne.Accounts.expenses
    shared = Shared(account: account, allPayments: [], allTransactions: [])
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

    var categorizedTransactions: [(String, String, Double)] {
      categorized
        .map { category, viewModels in
          (category, viewModels.first!.catemoji.emoji, viewModels.reduce(0.0, { $0 + $1.amount }))
        }
    }

    var categorized: [String: [TransactionViewModel]] {
      displayTransactions
        .grouped { $0.catemoji.category.name }
    }

    var categorizedAmount: [String: Double] {
      displayTransactions
        .grouped { $0.catemoji.category.name }
        .mapValues { $0.reduce(0, { $0 + $1.amount }) }
    }

    func range(with period: Period) -> Range<Date> {
      let calendar = Calendar.current
      let today = calendar.startOfDay(for: Date())

      switch period {
      case .weekly:
        let from = calendar.date(byAdding: .day, value: -7, to: today)!
        return from ..< today
      case .montly:
        let week = calendar.date(byAdding: .weekOfYear, value: -7, to: today)!
        return week.start(of: .week) ..< today
      case .yearly:
        let month = calendar.date(byAdding: .month, value: -7, to: today)!
        return month.start(of: .month) ..< today
      }
    }

    func labeledAmount(with period: Period) -> [(String, Double)] {
      let calendar = Calendar.current
      let today = calendar.startOfDay(for: Date())

      switch period {
      case .weekly:
        let intervals: TimeInterval = 24 * 60 * 60
        let from = calendar.date(byAdding: .day, value: -7, to: today)!
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return stride(from: from, to: Date(), by: intervals)
          .map { date -> (String, Double) in
            let label = formatter.string(from: date)
            let next = date.addingTimeInterval(intervals)
            let amount = allTransactions.filter {
              $0.date >= date && $0.date < next
            }
            .reduce(0, { $0 + $1.amount })
            return (label, amount)
          }

      case .montly:
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        var result = [(String, Double)]()
        for idx in (0..<7).reversed() {
          let week = calendar.date(byAdding: .weekOfYear, value: -idx, to: Date())!
          let start = week.start(of: .week)
          let end = week.end(of: .week)

          let label = formatter.string(from: week)
          let amount = allTransactions.filter {
            $0.date >= start && $0.date < end
          }
          .reduce(0, { $0 + $1.amount })
          result.append((label, amount))
        }

        return result
      case .yearly:
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        var result = [(String, Double)]()
        for idx in (0..<7).reversed() {
          let month = calendar.date(byAdding: .month, value: -idx, to: Date())!
          let start = month.start(of: .month)
          let end = month.end(of: .month)

          let label = formatter.string(from: month)
          let amount = allTransactions.filter {
            $0.date >= start && $0.date < end
          }
          .reduce(0, { $0 + $1.amount })
          result.append((label, amount))
        }
        return result
      }
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
