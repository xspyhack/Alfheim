//
//  Payment.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/24.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension Alne {
  enum Payments: Hashable {

    case cash
    case debitCard
    case creditCard(Credit)
    case uncleared

    var name: String {
      switch self {
      case .cash:
        return "Cash"
      case .debitCard:
        return "Debit Card"
      case .creditCard(let from):
        return "Credit Card - \(from.name)"
      case .uncleared:
        return "Uncleared"
      }
    }

    enum Credit: Hashable {
      case apple
      case wechat
      case alipay
      case unionpay

      var name: String {
        switch self {
        case .apple:
          return "Pay"
        case .wechat:
          return "Wechat"
        case .alipay:
          return "Alipay"
        case .unionpay:
          return "UnionPay"
        }
      }
    }

    static var allCases: [Payments] {
      [.cash, .debitCard, .creditCard(.apple), .creditCard(.wechat), .creditCard(.alipay), .creditCard(.unionpay), .uncleared]
    }
  }
}

extension Alne.Payments {
  init(_ name: String) {
    switch name {
    case "Cash":
      self = .cash
    case "Debit Card":
      self = .debitCard
    case "Credit Card - Pay":
      self = .creditCard(.apple)
    case "Credit Card - Wechat":
      self = .creditCard(.wechat)
    case "Credit Card - Alipay":
      self = .creditCard(.alipay)
    case "Credit Card - UnionPay":
      self = .creditCard(.unionpay)
    default:
      self = .uncleared
    }
  }
}
