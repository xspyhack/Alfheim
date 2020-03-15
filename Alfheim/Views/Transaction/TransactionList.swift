//
//  TransactionList.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/5.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct TransactionList: View {
  @EnvironmentObject var store: AppStore

  private var state: AppState.TransactionList {
    store.state.transactions
  }

  private var binding: Binding<AppState.TransactionList> {
    $store.state.transactions
  }

  private var tag: Tagit {
    store.state.shared.account.tag
  }

  var body: some View {
    List {
      ForEach(state.transactions) { transaction in
        TransactionRow(transaction: transaction, tag: self.tag)
          .onTapGesture {
            self.store.dispatch(.transactions(.editTransaction(transaction)))
        }
      }
      .onDelete { indexSet in
        self.store.dispatch(.transactions(.delete(at: indexSet)))
      }
    }
    .navigationBarTitle("Transactions")
    .sheet(
      isPresented: binding.editingTransaction,
      onDismiss: {
        self.store.dispatch(.transactions(.editTransactionDone))
    }) {
      ComposerView(mode: .edit).environmentObject(self.store)
    }/*
    .sheet(item: $transaction) { transaction in
      ComposerView(mode: .edit).environmentObject(self.store)
    }*/
  }
}

#if DEBUG
struct TransactionList_Previews: PreviewProvider {
  static var previews: some View {
    TransactionList()
  }
}
#endif
