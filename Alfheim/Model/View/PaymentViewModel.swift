//
//  PaymentViewModel.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/25.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import CoreData

extension Alne.Payment {
  init(_ object: Alfheim.Payment) {
    self.name = object.name
    self.kind = Alne.Payment.Kind(rawValue: Int(object.kind)) ?? .uncleared
  }
}

extension Alfheim.Payment {
  var fullname: String {
    guard let kind = Alne.Payment.Kind(rawValue: Int(kind)), kind != .uncleared else {
      return name
    }
    return "\(name) - \(kind.name)"
  }
}

struct PaymentViewModel: Identifiable {
  let payment: Alfheim.Payment
  let tag: Alne.Tagit

  let id: String
  var name: String
  var kind: Alne.Payment.Kind
  var description: String?

  init(payment: Alfheim.Payment, tag: Alne.Tagit) {
    self.payment = payment
    self.tag = tag
    self.id = payment.id.uuidString
    self.name = payment.name
    self.kind = Alne.Payment.Kind(rawValue: Int(payment.kind)) ?? .uncleared
    self.description = payment.introduction
  }
}

#if DEBUG
extension PaymentViewModel {
  static var mock: PaymentViewModel {
    let payment = Alfheim.Payment()
    payment.id = UUID()
    payment.name = "Pay"
    payment.kind = -1
    payment.introduction = "Apple Pay"
    return PaymentViewModel(payment: payment, tag: .alfheim)
  }
}
#endif
