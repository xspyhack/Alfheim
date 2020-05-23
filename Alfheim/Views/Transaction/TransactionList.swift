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

  @State var selectMonth = false
  @State private var birthDate = Date()

  var body: some View {
    List {
      Section(header:
        HStack {
          HStack(alignment: .lastTextBaseline) {
            Text(state.selectedMonth)
              .font(.system(size: 34, weight: .semibold))
              .foregroundColor(.primary)
            Text(state.selectedYear)
              .font(.system(size: 28, weight: .medium))
              .foregroundColor(.secondary)

            Image(systemName: "chevron.down")
              .font(.system(size: 16, weight: .medium))
              .foregroundColor(.secondary)
              .padding(.bottom, 2)
          }
          .onTapGesture {
            // select month
            self.store.dispatch(.transactions(.selectDate))
          }
          Spacer()
          NavigationLink(destination: StatisticList()) {
            Text(state.displayAmountText)
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
    }
    .overlaySheet(
      isPresented: binding.showDatePicker,
      onDismiss: {
        self.store.dispatch(.transactions(.selectDateCancalled))
    }) {
      VStack {
        HStack {
          Text(self.state.pickedDateText)
          Spacer()
          Button(action: {
            self.store.dispatch(.transactions(.selectDateDone(self.state.selectedDate)))
          }) {
            Text("OK").bold()
          }
        }
        .padding([.top, .leading, .trailing])
        DatePicker("",
                   selection: self.binding.selectedDate,
                   in: ...Date(),
                   displayedComponents: .date)
      }
      .background(Color(.systemBackground))
    }
    /*
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
