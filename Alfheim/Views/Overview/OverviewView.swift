//
//  OverviewView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct OverviewView: View {
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
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
            self.accountCard(height: geometry.size.width*9/16)
            Spacer().frame(height: 36)
            self.transactions()
          }
          .padding(18)
        }
      }
      .navigationBarTitle("Journals")
      .navigationBarItems(
        leading: Button(action: {
          self.store.dispatch(.overview(.toggleSettings(presenting: true)))
        }) {
          //Text("Settings").bold()
          Image(systemName: "gear").padding(.vertical).padding(.trailing)
        }
        .sheet(
          isPresented: binding.isSettingsPresented,
          onDismiss: {
            self.store.dispatch(.overview(.toggleSettings(presenting: false)))
        }) {
          SettingsView()
            .environmentObject(self.store)
        },
        trailing: Button(action: {
          self.store.dispatch(.overview(.toggleNewTransaction(presenting: true)))
        }) {
          //Text("New Transation").bold()
          //Image(systemName: "plus")
          Image(systemName: "plus.circle").padding(.vertical).font(Font.system(size: 18)).padding(.leading)
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
      .modal(isPresented: binding.isOnboardingPresented) {
        OnboardingView()
          .environmentObject(self.store)
      }

      // detail view in iPad
      Text("\(shared.account.description)")
        .onAppear {
          if self.horizontalSizeClass == .compact {
            self.store.dispatch(.overview(.onDetailed(false)))
          } else {
            self.store.dispatch(.overview(.onDetailed(true)))
          }
      }
    }
  }

  private func accountCard(height: CGFloat) -> some View {
    AccountCard()
      .frame(height: height)
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
  }

  private func transactions() -> some View {
    Section(header: NavigationLink(destination: TransactionList(), isActive: binding.isTransactionListActive) {
      HStack {
        Text("Transactions").font(.system(size: 24, weight: .bold))
        Spacer()
        Image(systemName: "chevron.right")
      }
      .foregroundColor(.primary)
    }) {
      ForEach(self.shared.displayTransactions) { viewModel in
        TransactionRow(model: viewModel)
          .onTapGesture {
            self.store.dispatch(.overview(.editTransaction(viewModel.transaction)))
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
}

#if DEBUG
struct OverviewView_Previews: PreviewProvider {
  static var previews: some View {
    OverviewView().environment(\.colorScheme, .dark).environmentObject(AppStore(moc: viewContext))
  }
}
#endif
