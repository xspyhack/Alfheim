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
    var isTransactionPresented: Bool = false
    var selectedTransaction: Transaction?
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
