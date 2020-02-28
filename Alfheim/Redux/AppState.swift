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
  var overview = Overview()
  var transactions = TransactionList()
  var editor = Editor()

  var period: Period = .montly
}

extension AppState {
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
  struct Overview {

    struct ViewState {
      var isEditorPresented: Bool = false
      var isStatisticsPresented: Bool = false
      var selectedTransaction: Transaction?
      var isAccountDetailPresented: Bool = false
    }

    var viewState = ViewState()


    var period: Period = .montly

    var account: Account = Accounts.expenses
    var amount: Double {
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

      return Transaction.samples()
        .filter { $0.date >= startDate }
        .map { $0.amount }
        .reduce(0.0, +)
    }

    var amountText: String {
      "\(account.currency.symbol)\(amount)"
    }
  }
}

extension AppState {
  struct TransactionList {
  }
}

extension AppState {
  struct Editor {
  }
}
