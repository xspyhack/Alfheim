//
//  Payment.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/24.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension Alne {
  struct Payment {
    var name: String
    var kind: Kind

    enum Kind: Int, CaseIterable {
      case uncleared = -1
      case cash
      case debit
      case credit

      var name: String {
        switch self {
        case .cash:
          return "Cash"
        case .debit:
          return "Debit"
        case .credit:
          return "Credit"
        case .uncleared:
          return "Uncleared"
        }
      }

      var fullname: String {
        switch self {
        case .cash:
          return "Cash"
        case .debit:
          return "Debit Card"
        case .credit:
          return "Credit Card"
        case .uncleared:
          return "Uncleared"
        }
      }
    }
  }
}

extension Alne.Payment: Hashable {}

extension Alne {
  enum Payments: Hashable {

    static var uncleared: Payment {
      Payment(name: "Uncleared", kind: .uncleared)
    }

    static var cash: Payment {
      Payment(name: "Cash", kind: .cash)
    }

    enum Wechat {
      static var balance: Payment {
        Payment(name: "Wechat", kind: .cash)
      }

      static var debit: Payment {
        Payment(name: "Wechat", kind: .debit)
      }

      static var credit: Payment {
        Payment(name: "Wechat", kind: .credit)
      }
    }

    enum Alipay {
      static var balance: Payment {
        Payment(name: "Alipay", kind: .cash)
      }

      static var debit: Payment {
        Payment(name: "Alipay", kind: .debit)
      }

      static var credit: Payment {
        Payment(name: "Alipay", kind: .credit)
      }
    }

    static var debitCard: Payment {
      return Payment(name: "Debit Card", kind: .debit)
    }

    static var creditCard: Payment {
      return Payment(name: "Credit Card", kind: .credit)
    }

    static var applePay: Payment {
      return Payment(name: "Pay", kind: .credit)
    }

    static var allCases: [Payment] {
      [
        Payments.applePay,
        Payments.cash,
        Payments.debitCard,
        Payments.creditCard,
        //Payments.Wechat.balance,
        //Payments.Wechat.debit,
        Payments.Wechat.credit,
        //Payments.Alipay.balance,
        //Payments.Alipay.debit,
        Payments.Alipay.credit,
      ]
    }
  }
}
