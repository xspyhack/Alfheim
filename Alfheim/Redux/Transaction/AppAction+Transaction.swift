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

    case delete(at: IndexSet, in: Alfheim.Transaction)

    case reset(Bool)

    // picker date
    case selectDate
    case selectDateDone(Date)
    case selectDateCancalled

    case showStatistics([Alfheim.Transaction], timeRange: Range<Date>)
    case dimissStatistics
  }
}
