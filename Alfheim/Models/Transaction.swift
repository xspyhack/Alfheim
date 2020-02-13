//
//  Transaction.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/3.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

struct Transaction {
  var date: Date
  var amount: Double
  var notes: String
  var account: Bool?
  var payee: String?
  var number: Int
}
