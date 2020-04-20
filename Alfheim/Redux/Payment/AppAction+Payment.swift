//
//  AppAction+Payment.swift
//  Alfheim
//
//  Created by alex.huo on 2020/4/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppAction {
  enum Payment {
    case updated([Alfheim.Payment])
    case loadPayment(kind: Int)
    case loadPaymentDone(Alfheim.Payment)
  }
}
