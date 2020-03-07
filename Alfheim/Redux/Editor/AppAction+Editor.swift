//
//  AppAction+Editor.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/3/7.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppAction {
  enum Editors {
    case save(Transaction)
    case validate(valid: Bool)
    case edit(Transaction)
    case new
  }
}
