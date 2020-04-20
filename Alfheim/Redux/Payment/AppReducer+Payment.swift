//
//  AppReducer+Payment.swift
//  Alfheim
//
//  Created by alex.huo on 2020/4/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppReducers {
  enum Payment {
    static func reduce(state: AppState, action: AppAction.Payment) -> (AppState, AppCommand?) {
      var appState = state
      var appCommand: AppCommand? = nil

      switch action {
      case .updated(let payments):
        appState.shared.allPayments = payments
        appState.payment.payments = payments
        appState.editor.payments = payments

        if !(payments.filter { $0.kind == -1 }).isEmpty {
          //appState.editor.validator.defaultPayment = payment
        } else {
          appCommand = AppCommands.LoadPaymentCommand(kind: -1)
        }
      case .loadPayment(let kind):
        appCommand = AppCommands.LoadPaymentCommand(kind: kind)
      case .loadPaymentDone(let payment):
        if payment.kind == -1 {
          //appState.editor.validator.defaultPayment = payment
        }
      }

      return (appState, appCommand)
    }
  }
}
