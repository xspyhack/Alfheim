//
//  AppAction+Editor.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/12.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppAction {
  enum Editors {
    case save(Alne.Transaction, update: Bool)
    case validate(valid: Bool)
    case edit(Alne.Transaction)
    case new
  }
}
