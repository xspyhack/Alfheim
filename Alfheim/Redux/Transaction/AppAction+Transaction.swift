//
//  AppAction+Transaction.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/12.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppAction {
  enum Transactions {
    case updated([Alne.Transaction])
    case loadAll
    case loadAllDone([Alne.Transaction])

    case editTransaction(Alne.Transaction)
    case editTransactionDone

    case delete(at: IndexSet)
  }
}
