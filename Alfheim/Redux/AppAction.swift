//
//  AppAction.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

enum AppAction {
  case overview(Overview)


  case settings(Settings)


  case account(Account)
}

extension AppAction {
  enum Overview {
    case toggleNewTransaction(presenting: Bool)
    case editTransaction(Transaction)
    case editTransactionDone
    case toggleStatistics(presenting: Bool)
    case toggleAccountDetail(presenting: Bool)
    case switchPeriod
  }
}

extension AppAction {
  enum Settings {

  }
}

extension AppAction {
  enum Account {

  }
}
