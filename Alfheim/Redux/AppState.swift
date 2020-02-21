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
    var isEditorPresented: Bool = false
    var isStatisticsPresented: Bool = false
    var isEditingTransaction: Bool = false
    var selectedTransaction: Transaction?
    var isAccountDetailPresented: Bool = false

    var account: Account = Accounts.expenses

    enum Period {
      case weekly
      case month(String)
      case year(String)

      var display: String {
        switch self {
        case .weekly:
          return "this week"
        case .month(let text):
          return text
        case .year(let text):
          return text
        }
      }
    }

    var period: Period = .weekly
    var amount: Double = 233.0

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
