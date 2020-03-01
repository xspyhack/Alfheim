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

  private var binding: Binding<AppState.Overview> {
    $store.state.overview
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
                      self.store.dispatch(.overviews(.toggleStatistics(presenting: false)))
                    }
                }
              )
              .onTapGesture {
                self.store.dispatch(.overviews(.toggleStatistics(presenting: true)))
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
              ForEach(Transaction.samples()) { transaction in
                TransactionRow(transaction: transaction)
                  .onTapGesture {
                    self.store.dispatch(.overviews(.editTransaction(transaction)))
                }
              }
            }
            .sheet(item: self.binding.selectedTransaction) {
              ComposerView(transaction: $0) {
                self.store.dispatch(.overviews(.editTransactionDone))
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
          self.store.dispatch(.overviews(.toggleNewTransaction(presenting: true)))
        }) {
          Text("New Transaction").bold()
        }
        .sheet(isPresented: binding.isEditorPresented) {
          ComposerView(transaction: nil) {
            self.store.dispatch(.overviews(.toggleNewTransaction(presenting: false)))
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
    private var state: AppState.Shared {
      store.state.shared
    }

    private var binding: Binding<AppState.Overview> {
      $store.state.overview
    }

    @State private var flipped: Bool = false

    private let cornerRadius: CGFloat = 20

    var body: some View {
      ZStack {
        frontSide().opacity(flipped ? 0 : 1)
        backSide().opacity(flipped ? 1 : 0)
      }
      .background(
        RoundedRectangle(cornerRadius: cornerRadius)
          .fill(Color(tagit: state.account.tag))
          .shadow(radius: 8)
      ).rotation3DEffect(.degrees(flipped ? -180 : 0), axis: (x: 0, y: 1, z: 0))
    }

    private func frontSide() -> some View {
      ZStack {
        VStack {
          HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
              Button(action: {
                self.store.dispatch(.overviews(.toggleAccountDetail(presenting: true)))
              }) {
                Text(state.account.name)
                  .font(.system(size: 22, weight: .semibold))
                  .foregroundColor(.primary)
              }
              .sheet(isPresented: binding.isAccountDetailPresented) {
                AccountDetail() {
                  self.store.dispatch(.overviews(.toggleAccountDetail(presenting: false)))
                }
                .environmentObject(self.store)
              }

              Button(action: {
                self.store.dispatch(.overviews(.switchPeriod))
              }) {
                Image(systemName: "chevron.right")
                  .resizable()
                  .frame(width: 8, height: 8)
                  .foregroundColor(.secondary).padding(.bottom, -1)
                Text(state.period.display).font(.callout)
                  .foregroundColor(.secondary).padding(.leading, -4)
              }
            }
            Spacer()
            Button(action: {
              self.flip(true)
            }) {
              Image(systemName: "info.circle")
                .foregroundColor(.primary)
                .padding(.top, 5)
            }
          }
          Spacer()
        }
        .padding([.leading, .top, .trailing])

        Text(state.amountText)
          .gradient(LinearGradient(
            gradient: Gradient(colors: [.pink, .purple]),
            startPoint: .leading,
            endPoint: .trailing
          ))
          .font(.system(size: 36, weight: .semibold))
          .padding(.top, 2.0)
      }
    }

    private func backSide() -> some View {
      ZStack(alignment: .topTrailing) {
        ZStack {
          Color(tagit: state.account.tag).cornerRadius(cornerRadius)
            .onTapGesture {
              self.flip(false)
          }
          VStack {
            Spacer()
            Text(state.account.description)
            Spacer()
            HStack {
              Spacer()
              Text("made with ❤️").font(.footnote)
            }
          }
          .padding()
        }

        Image(systemName: "dollarsign.circle.fill")
          .foregroundColor(.primary)
          .padding(.top, 5)
          .padding()
      }
      .rotation3DEffect(.degrees(-180), axis: (x: 0, y: 1, z: 0))
    }

    private func flip(_ flag: Bool) {
      withAnimation(.easeOut(duration: 0.35)) {
        self.flipped = flag
      }
    }
  }
}


#if DEBUG
struct AccountCard_Previews: PreviewProvider {
  static var previews: some View {
    OverviewView.AccountCard().environment(\.colorScheme, .dark).environmentObject(AppStore())
  }
}
#endif

#if DEBUG
struct OverviewView_Previews: PreviewProvider {
  static var previews: some View {
    OverviewView().environment(\.colorScheme, .dark).environmentObject(AppStore())
  }
}
#endif
