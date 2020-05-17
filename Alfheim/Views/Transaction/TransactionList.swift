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
      Section(header:
        HStack {
          HStack(alignment: .lastTextBaseline) {
            Text("May")
              .font(.system(size: 34, weight: .semibold))
              .foregroundColor(.primary)
            Text("2020")
              .font(.system(size: 28, weight: .medium))
              .foregroundColor(.secondary)

            Image(systemName: "chevron.down")
              .font(.system(size: 16, weight: .medium))
              .foregroundColor(.secondary)
              .padding(.bottom, 2)
          }
          .onTapGesture {
            // select month
          }
          Spacer()
          NavigationLink(destination: StatisticList()) {
            Text("$233")
              .font(.system(size: 18))
              .foregroundColor(.secondary)
            Image(systemName: "chevron.right")
              .font(.system(size: 18))
              .foregroundColor(.secondary)
          }
        }
        .foregroundColor(.primary)
      ) {
        ForEach(state.displayViewModels(tag: self.tag)) { viewModel in
          TransactionRow(model: viewModel)
            .onTapGesture {
              self.store.dispatch(.transactions(.editTransaction(viewModel.transaction)))
          }
        }
        .onDelete { indexSet in
          self.store.dispatch(.transactions(.delete(at: indexSet)))
        }
      }
    }
    .listStyle(GroupedListStyle())
    .navigationBarTitle("Transactions", displayMode: .inline)
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
