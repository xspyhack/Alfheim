//
//  OverviewView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct OverviewView: View {
  @State private var showModel: Bool = false
  @State private var showAccountDetail: Bool = false
  @State private var showTransactions: Bool = false

  #if targetEnvironment(macCatalyst)
  var body: some View {
      SplitView()
  }
  #else
  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ScrollView(.vertical, showsIndicators: false) {
          VStack(spacing: 28) {
            AccountCard()
              .frame(width: nil, height: geometry.size.width*9/16, alignment: .center)
              .onTapGesture {
                self.showAccountDetail.toggle()
            }
            .sheet(isPresented: self.$showAccountDetail) {
              AccountDetail(account: Accounts.expenses)
            }

            Section(header: HStack {
              Text("Transactions").font(.system(size: 24, weight: .bold))
              Spacer()
              Image(systemName: "chevron.right")
            }.onTapGesture {
              self.showTransactions.toggle()
            }) {
              TransactionList()
            }.sheet(isPresented: self.$showTransactions) {
              TransactionsView()
            }
          }
          .padding(20)
        }
      }
      .navigationBarTitle("Journals")
      .navigationBarItems(trailing:
        Button(action: {
          self.showModel.toggle()
        }) {
          Text("New Transaction").bold()
        }.sheet(isPresented: $showModel) {
          EditorView()
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
  var body: some View {
    ZStack {
      VStack {
        HStack {
          VStack(alignment: .leading, spacing: 6) {
            Text("Expences")
              .font(.system(size: 22, weight: .semibold))
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
