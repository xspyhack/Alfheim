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

    var period: Period = .montly

    var account: Account = Accounts.expenses
    var amount: Double {
      switch period {
      case .weekly:
        return 233.0
      case .montly:
        return 2333.0
      case .yearly:
        return 23333.0
      }
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
