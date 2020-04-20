//
//  AppState+Payment.swift
//  Alfheim
//
//  Created by alex.huo on 2020/4/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppState {
  /// Payment  state
  struct Payment {
    var payments: [Alfheim.Payment] = []

    func displayViewModels(tag: Alne.Tagit) -> [PaymentViewModel] {
      return payments
        .map { PaymentViewModel(payment: $0, tag: tag) }
    }
  }
}
