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

  private var viewModel: TransactionListViewModel {
    state.listViewModel(filterDate: filterDate, tag: tag)
  }

  @State private var filterDate = Date()
  @State private var selectedDate = Date()
  @State private var showDatePicker = false

  var body: some View {
    List {
      Section(header:
        HStack {
          HStack(alignment: .lastTextBaseline) {
            Text(viewModel.selectedMonth)
              .font(.system(size: 34, weight: .semibold))
              .foregroundColor(.primary)
            Text(viewModel.selectedYear)
              .font(.system(size: 28, weight: .medium))
              .foregroundColor(.secondary)

            Image(systemName: "chevron.down")
              .font(.system(size: 16, weight: .medium))
              .foregroundColor(.secondary)
              .padding(.bottom, 2)
          }
          .onTapGesture {
            // select month
            self.showDatePicker = true
            //self.store.dispatch(.transactions(.selectDate))
          }
          Spacer()
          Button(action: {
            self.store.dispatch(.transactions(.toggleStatistics(presenting: true)))
          }) {
            Text(self.viewModel.displayAmountText)
              .font(.system(size: 18))
              .foregroundColor(.secondary)
            Image(systemName: "chevron.right")
              .font(.system(size: 18))
              .foregroundColor(.secondary)
          }
          .modal(
            isPresented: self.binding.isStatisticsPresented,
            onDismiss: {
              self.store.dispatch(.transactions(.toggleStatistics(presenting: false)))
          }) {
            StatisticsView().environmentObject(self.store)
          }
        }
        .foregroundColor(.primary)
      ) {
        ForEach(self.viewModel.viewModels) { viewModel in
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
      isPresented: self.$showDatePicker,
      onDismiss: {
        self.showDatePicker = false
//        self.store.dispatch(.transactions(.selectDateCancalled))
    }) {
      VStack {
        HStack {
          Text(self.pickedDateText)
            .fontWeight(.medium)
          Spacer()
          Button(action: {
            self.showDatePicker = false
            self.store.dispatch(.transactions(.selectDateDone(self.selectedDate)))
          }) {
            Text("OK").bold()
          }
        }
        .padding([.top, .leading, .trailing])
        DatePicker("",
                   selection: self.$selectedDate,
                   in: ...Date(),
                   displayedComponents: .date)
          .datePickerStyle(WheelDatePickerStyle())
          .background(Color(.systemBackground))
      }
      .background(Color(.secondarySystemBackground))
    }
  }

  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM, yyyy"
    return formatter
  }()

  private var pickedDateText: String {
    return dateFormatter.string(from: selectedDate)
  }
}

#if DEBUG
struct TransactionList_Previews: PreviewProvider {
  static var previews: some View {
    TransactionList()
  }
}
#endif
