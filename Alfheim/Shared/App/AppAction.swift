//
//  AppAction.swift
//  Alfheim
//
//  Created by alex.huo on 2021/2/6.
//  Copyright © 2021 blessingsoft. All rights reserved.
//

import Foundation

enum AppAction {
  case overview(Overview)
//  case editor(Editor)
//  case settings(Settings)
  case account(Account)
//  case transactions(Transactions)
//  case payment(Payment)
//  case catemoji(Catemoji)

//  case startImport
//  case finishImport

  case load
}

extension AppAction {
  enum EditMode {
    case new
    case update
    case delete
  }
}
