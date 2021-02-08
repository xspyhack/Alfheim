//
//  EditorViewModel.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/6.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

struct EditorViewModel {
  let transaction: Alfheim.Transaction?

  var date: Date = Date()
  var amount = ""
  var catemoji = Catemoji(uncleared: .uncleared)
  var notes: String = ""
  var currency: Currency = .cny
  var payment: Payment?
}
