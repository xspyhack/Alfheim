//
//  AppAction.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

enum AppAction {
  case overviews(Overviews)
  case settings(Settings)
  case accounts(Accounts)
}

extension AppAction {
  enum Overviews {
    case toggleNewTransaction(presenting: Bool)
    case editTransaction(Alne.Transaction)
    case editTransactionDone
    case toggleStatistics(presenting: Bool)
    case toggleAccountDetail(presenting: Bool)
    case switchPeriod
  }
}

extension AppAction {
  enum Settings {
    case togglePayment
  }
}

extension AppAction {
  enum Accounts {
    case update(Alne.Account)
  }
}
