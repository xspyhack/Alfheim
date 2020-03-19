//
//  OverviewView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct OverviewView: View {
  /// App Store
  @EnvironmentObject var store: AppStore
  /// Ovewview state
  private var state: AppState.Overview {
    store.state.overview
  }
  /// Shared state
  private var shared: AppState.Shared {
    store.state.shared
  }
  /// Overview binding
  private var binding: Binding<AppState.Overview> {
    $store.state.overview
  }

  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ScrollView(.vertical, showsIndicators: false) {
          VStack {
            AccountCard()
              .frame(height: geometry.size.width*9/16)
              .background(
                Spacer()
                  .sheet(
                    isPresented: self.binding.isStatisticsPresented,
                    onDismiss: {
                      self.store.dispatch(.overview(.toggleStatistics(presenting: false)))
                  }) {
                    StatisticsView().environmentObject(self.store)
                }
              )
              .onTapGesture {
                self.store.dispatch(.overview(.toggleStatistics(presenting: true)))
            }

            Spacer().frame(height: 36)

            Section(header: NavigationLink(destination: TransactionList()) {
              HStack {
                Text("Transactions").font(.system(size: 24, weight: .bold))
                Spacer()
                Image(systemName: "chevron.right")
              }
              .foregroundColor(.primary)
            }) {
              ForEach(self.shared.displayTransactions) { transaction in
                TransactionRow(transaction: transaction, tag: self.shared.account.tag)
                  .onTapGesture {
                    self.store.dispatch(.overview(.editTransaction(transaction)))
                }
              }
            }
            .sheet(
              isPresented: self.binding.editingTransaction,
              onDismiss: {
                self.store.dispatch(.overview(.editTransactionDone))
            }) {
              ComposerView(mode: .edit).environmentObject(self.store)
            }
            /* don't use this
            .sheet(item: self.binding.selectedTransaction) { transaction in
              ComposerView(mode: .edit) {
                self.store.dispatch(.overview(.editTransactionDone))
              }
              .environmentObject(self.store)
            }*/
          }
          .padding(18)
        }
      }
      .navigationBarTitle("Journals")
      .navigationBarItems(trailing:
        Button(action: {
          self.store.dispatch(.overview(.toggleNewTransaction(presenting: true)))
        }) {
          Text("New Transaction").bold()
        }
        .sheet(
          isPresented: binding.isEditorPresented,
          onDismiss: {
            self.store.dispatch(.overview(.toggleNewTransaction(presenting: false)))
        }) {
          ComposerView(mode: .new)
            .environmentObject(self.store)
        }
      )
    }
  }
}

#if DEBUG
struct OverviewView_Previews: PreviewProvider {
  static var previews: some View {
    OverviewView().environment(\.colorScheme, .dark).environmentObject(AppStore(moc: viewContext))
  }
}
#endif
