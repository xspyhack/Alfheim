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
  case editors(Editors)
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
  enum Editors {
    case save(Alne.Transaction)
    case validate(valid: Bool)
    case edit(Alne.Transaction)
    case new
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
    case updateDone(Alne.Account)
  }
}
