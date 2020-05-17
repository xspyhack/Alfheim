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
    case updated([Alfheim.Transaction])
    case loadAll
    case loadAllDone([Alfheim.Transaction])

    case editTransaction(Alfheim.Transaction)
    case editTransactionDone

    case delete(at: IndexSet)

    // picker date
    case selectDate
    case selectDateDone(Date)
  }
}
