//
//  OverviewView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct OverviewView: View {

  @EnvironmentObject var store: AppStore

  private var state: AppState.Overview {
    store.state.overview
  }

  private var binding: Binding<AppState.Overview.ViewState> {
    $store.state.overview.viewState
  }

  #if targetEnvironment(macCatalyst)
  var body: some View {
      SplitView()
  }
  #else
  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ScrollView(.vertical, showsIndicators: false) {
          VStack {
            AccountCard()
              .frame(height: geometry.size.width*9/16)
              .background(
                Spacer()
                  .sheet(isPresented: self.binding.isStatisticsPresented) {
                    StatisticsView() {
                      self.store.dispatch(.overview(.toggleStatistics(presenting: false)))
                    }
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
              .foregroundColor(.black)
            }) {
              ForEach(Transaction.samples()) { transaction in
                TransactionRow(transaction: transaction)
                  .onTapGesture {
                    self.store.dispatch(.overview(.editTransaction(transaction)))
                }
              }
            }
            .sheet(item: self.binding.selectedTransaction) {
              ComposerView(transaction: $0) {
                self.store.dispatch(.overview(.editTransactionDone))
              }
            }
            /*
            .sheet(isPresented: self.binding.isEditingTransaction) {
              ComposerView(transaction: self.state.selectedTransaction) {
                self.store.dispatch(.overview(.editTransactionDone))
              }
            }
            */
          }
          .padding(20)
        }
      }
      .navigationBarTitle("Journals")
      .navigationBarItems(trailing:
        Button(action: {
          self.store.dispatch(.overview(.toggleNewTransaction(presenting: true)))
        }) {
          Text("New Transaction").bold()
        }
        .sheet(isPresented: binding.isEditorPresented) {
          ComposerView(transaction: nil) {
            self.store.dispatch(.overview(.toggleNewTransaction(presenting: false)))
          }
        }
      )
    }
  }
  #endif
}

struct SplitView: View {
  var body: some View {
    Text("Hello split view")
  }
}

extension OverviewView {
  struct AccountCard: View {

    @EnvironmentObject var store: AppStore
    private var state: AppState.Overview {
      store.state.overview
    }

    private var binding: Binding<AppState.Overview.ViewState> {
      $store.state.overview.viewState
    }

    var body: some View {
      ZStack {
        VStack {
          HStack {
            VStack(alignment: .leading, spacing: 6) {
              Button(action: {
                self.store.dispatch(.overview(.toggleAccountDetail(presenting: true)))
              }) {
                Text(self.state.account.name)
                  .font(.system(size: 22, weight: .semibold))
              }
              .sheet(isPresented: self.binding.isAccountDetailPresented) {
                AccountDetail(account: self.state.account) {
                  self.store.dispatch(.overview(.toggleAccountDetail(presenting: false)))
                }
              }

              Button(action: {
                self.store.dispatch(.overview(.switchPeriod))
              }) {
                Text(self.state.period.display).font(.callout)
                  .foregroundColor(.gray)
                //Image(systemName: "chevron.down")
              }
            }
            Spacer()
          }
          Spacer()
        }
        .padding([.leading, .top])

        Text(state.amountText)
          .font(.system(size: 36, weight: .semibold))
          .padding(.top, 2)
      }
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(Color.yellow)
          .shadow(radius: 8)
      )
    }
  }
}

#if DEBUG
struct AccountCard_Previews: PreviewProvider {
  static var previews: some View {
    OverviewView.AccountCard().environment(\.colorScheme, .dark)
  }
}
#endif

#if DEBUG
struct OverviewView_Previews: PreviewProvider {
  static var previews: some View {
    OverviewView().environment(\.colorScheme, .dark)
  }
}
#endif
