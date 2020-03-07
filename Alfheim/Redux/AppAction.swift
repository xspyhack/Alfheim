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
  enum Settings {
    case togglePayment
  }
}
