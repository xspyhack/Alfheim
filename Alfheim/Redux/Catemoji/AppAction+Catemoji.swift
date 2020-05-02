//
//  AppAction+Catemoji.swift
//  Alfheim
//
//  Created by alex.huo on 2020/5/2.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppAction {
  enum Catemoji {
    case updated([Alne.Catemoji])
    case toggleAddCatemoji(presenting: Bool)
    case added(Alne.Catemoji)
    case deleted(Alne.Catemoji)
  }
}
