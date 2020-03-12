//
//  AppState+Editor.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/12.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine

extension AppState {
  /// Composer, editor state
  struct Editor {
    enum Mode {
      case new
      case edit(Alne.Transaction)

      var isNew: Bool {
        switch self {
        case .new:
          return true
        default:
          return false
        }
      }
    }

    class Validator {
      @Published var amount: String = ""
      @Published var currency: Currency = .cny
      @Published var emoji: Catemoji = Catemoji.fruit(.apple)
      @Published var date: Date = Date()
      @Published var notes: String = ""
      @Published var payment: String = "Pay"

      var mode: Mode = .new

      func reset(_ mode: Mode) {
        switch mode {
        case .new:
          amount = ""
          currency = .cny
          emoji = Catemoji.fruit(.apple)
          date = Date()
          notes = ""
          payment = "Pay"
        case .edit(let transaction):
          amount = "\(transaction.amount)"
          currency = transaction.currency
          emoji = transaction.catemoji
          date = transaction.date
          notes = transaction.notes
          payment = transaction.payment ?? "Pay"
        }
        self.mode = mode
      }

      var isAmountValid: AnyPublisher<Bool, Never> {
        $amount.map { $0.isValidAmount }
          .eraseToAnyPublisher()
      }

      var isNotesValid: AnyPublisher<Bool, Never> {
        $notes.map { $0 != "" }
          .eraseToAnyPublisher()
      }

      var isValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isAmountValid, isNotesValid).map { $0 && $1 }
          .eraseToAnyPublisher()
      }

      var transaction: Alne.Transaction {
        switch mode {
        case .new:
          return Alne.Transaction(date: date,
                             amount: Double(amount)!,
                             catemoji: emoji,
                             notes: notes,
                             currency: currency)
        case .edit(let transaction):
          return Alne.Transaction(id: transaction.id,
                             date: date,
                             amount: Double(amount)!,
                             catemoji: emoji,
                             notes: notes,
                             currency: currency)
        }
      }
    }

    var validator = Validator()
    var isValid: Bool = false
    
    var isNew: Bool {
      return validator.mode.isNew
    }
  }
}

extension String {
  var isValidAmount: Bool {
    self != "" && Double(self) != nil
  }
}
