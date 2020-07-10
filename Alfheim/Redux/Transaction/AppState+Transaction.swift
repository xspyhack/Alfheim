//
//  AppState+Transaction.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/3/7.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import CoreData
import Combine

extension AppState {
  /// Transaction list view state
  struct TransactionList {
    var transactions: [Alfheim.Transaction] = []

    var isStatisticsPresented: Bool = false

    var isLoading = false
    var currency: Currency = .cny

    var selectedTransaction: Alfheim.Transaction?
    var editingTransaction: Bool = false

    var searchText = ""

    func listViewModel(filterDate: Date, tag: Alne.Tagit) -> TransactionListViewModel {
      let timeRange = filterDate.start(of: .month)..<filterDate.next(of: .month).start(of: .month)

      return TransactionListViewModel(
        transactions: transactions.filter { timeRange.contains($0.date) },
        tag: tag,
        currency: currency,
        filterDate: filterDate
      )
    }

    func transactions(in range: Range<Date>) -> [Alfheim.Transaction] {
      return transactions.filter { range.contains($0.date) }
    }

    func displayTransactions(from start: Date, to end: Date, tag: Alne.Tagit) -> [TransactionViewModel] {
      return transactions
        .sorted(by: { $0.date > $1.date })
        .filter { $0.date <= end && $0.date >= start }
        .map { TransactionViewModel(transaction: $0, tag: tag) }
    }

    final class Loader {
      @Published var from: Date = Date()
      @Published var to: Date = Date()

      var filter: AnyPublisher<(Date, Date), Never> {
        Publishers.Zip($from, $to).eraseToAnyPublisher()
      }

      var token = SubscriptionToken()
    }

    var loader = Loader()
  }
}

extension Date {
  var month: Range<Date> {
    self.start(of: .month)..<self.next(of: .month).start(of: .month)
  }
}
