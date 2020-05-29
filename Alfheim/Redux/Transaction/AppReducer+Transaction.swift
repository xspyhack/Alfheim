//
//  AppReducer+Transaction.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/15.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppReducers {
  enum Transactions {
    static func reduce(state: AppState, action: AppAction.Transactions) -> (AppState, AppCommand?) {
      var appState = state
      var appCommand: AppCommand? = nil

      switch action {
      case .updated(let transactions):
        appState.shared.allTransactions = transactions
        appState.transactions.transactions = transactions
      case .loadAll:
        appState.transactions.isLoading = true
        appState.transactions.loader.token.unseal() // cancel previous load and observer
        let loader = appState.transactions.loader
        appCommand = AppCommands.LoadTransactionsCommand(filter: loader.filter, token: loader.token)
      case .loadAllDone(let transactions):
        appState.transactions.transactions = transactions
        appState.transactions.isLoading = false
      case .editTransaction(let transaction):
        appState.transactions.selectedTransaction = transaction
        appState.transactions.editingTransaction = true
        appState.editor.isValid = true // Important! need set here
        appState.editor.validator.reset(.edit(transaction))
      case .editTransactionDone:
        appState.transactions.selectedTransaction = nil
        appState.transactions.editingTransaction = false
        appState.editor.isValid = false // Important! need set here
        appState.editor.validator.reset(.new)
      case .delete(at: let indexSet):
        let transactions = state.transactions.transactions.elements(atOffsets: indexSet)
        appCommand = AppCommands.DeleteTransactionCommand(transactions: transactions)

      case .export:
        let data = try? JSONEncoder().encode(state.shared.allTransactions)
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = directory.appendingPathComponent("alfheim.json")
        try? data?.write(to: url)
        appState.transactions.file = url
      }

      return (appState, appCommand)
    }
  }
}
