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
}

extension AppState {
  /// Shared global state
  struct Shared {
    var account: Alne.Account
    /// this should be latest selected period
    var period: Period = .montly

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

    var amount: Double {
      periodTransactions
        .map { $0.amount }
        .reduce(0.0, +)
    }

    var amountText: String {
      "\(account.currency.symbol)\(amount)"
    }
  }
}

extension AppState {
  /// Overview view state
  struct Overview {
    var isEditorPresented: Bool = false
    var isStatisticsPresented: Bool = false
    var selectedTransaction: Alne.Transaction?
    var isAccountDetailPresented: Bool = false

    var transactions: [Alne.Transaction] {
      Alne.Transactions.samples()
    }
  }
}

extension AppState {
  /// Transaction list view state
  struct TransactionList {
  }
}

extension AppState {
  /// Composer, editor state
  struct Editor {
    class Validator {
      @Published var amount: String = ""
      @Published var currency: Alne.Currency = .cny
      @Published var emoji: Alne.Catemoji = Alne.Catemoji.fruit(.apple)
      @Published var date: Date = Date()
      @Published var notes: String = ""
      @Published var payment: String = "Pay"

      init(_ transaction: Alne.Transaction) {
        amount = "\(transaction.amount)"
        currency = transaction.currency
        emoji = transaction.catemoji
        date = transaction.date
        notes = transaction.notes
        payment = transaction.payment ?? "Pay"
      }

      init() {
      }

      var isAmountValid: AnyPublisher<Bool, Never> {
        $amount.map { $0.isValidAmount }
          .eraseToAnyPublisher()
      }

      var isNotesValid: AnyPublisher<Bool, Never> {
        $notes.map { $0 != "" }
          .eraseToAnyPublisher()
      }

      var isValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isAmountValid, isNotesValid).map { $0 && $1 }
          .eraseToAnyPublisher()
      }

      var transaction: Alne.Transaction {
        Alne.Transaction(date: date,
                         amount: Double(amount)!,
                         catemoji: emoji,
                         notes: notes)
      }
    }

    var validator = Validator()
    var isValid: Bool = false
  }
}

extension String {
  var isValidAmount: Bool {
    self != "" && Double(self) != nil
  }
}

extension AppState {
  /// Account detail view state
  struct AccountDetail {
    /// editing account
    var account: Alne.Account
  }
}

extension AppState {
  struct Settings {
    var isPaymentEnabled = true
  }
}
