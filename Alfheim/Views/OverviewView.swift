//
//  OverviewView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct OverviewView: View {
  @State private var showEditor: Bool = false
  @State private var showStatistics: Bool = false
  @State private var showTransactions: Bool = false
  @State private var showTransaction: Bool = false
  @State private var transaction: Transaction?

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
              .frame(width: nil, height: geometry.size.width*9/16)
              .background(
                Spacer()
                  .sheet(isPresented: self.$showStatistics) {
                    StatisticsView()
                }
              )
              .onTapGesture {
                self.showStatistics.toggle()
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
                    self.transaction = transaction
                    self.showTransaction.toggle()
                    print("tap")
                }
              }
            }
            .sheet(isPresented: self.$showTransaction) {
              EditorView(transaction: self.transaction)
            }
          }
          .padding(20)
        }
      }
      .navigationBarTitle("Journals")
      .navigationBarItems(trailing:
        Button(action: {
          self.showEditor.toggle()
        }) {
          Text("New Transaction").bold()
        }
        .sheet(isPresented: $showEditor) {
          EditorView(transaction: nil)
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

struct AccountCard: View {
  @State private var showAccountDetail: Bool = false

  var body: some View {
    ZStack {
      VStack {
        HStack {
          VStack(alignment: .leading, spacing: 6) {
            Button(action: {
              self.showAccountDetail.toggle()
            }) {
              Text("Expences")
                .font(.system(size: 22, weight: .semibold))
            }
            .sheet(isPresented: self.$showAccountDetail) {
              AccountDetail(account: Accounts.expenses)
            }

            Button(action: {

            }) {
              Text("this week").font(.callout)
                .foregroundColor(.gray)
              //Image(systemName: "chevron.down")
            }
          }
          Spacer()
        }
        Spacer()
      }
      .padding([.leading, .top])

      Text("$2333.33")
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

#if DEBUG
struct AccountCard_Previews: PreviewProvider {
  static var previews: some View {
    AccountCard().environment(\.colorScheme, .dark)
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
