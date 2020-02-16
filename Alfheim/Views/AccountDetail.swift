//
//  AccountDetail.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/15.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct AccountDetail: View {
  var account: Account
  
  var body: some View {
    NavigationView {
      List {
        Section(header: Spacer()) {
          Text(account.name)
          Text(account.description)
//          Text(account.emoji ?? "")
        }

        Section {
          ForEach(0..<7) { i in
            HStack {
              Circle().fill(Color.red).frame(width: 20, height: 20)
              Text("Red")
              Spacer()
            }
          }
        }
      }
      .listStyle(GroupedListStyle())
      .environment(\.horizontalSizeClass, .regular)
      .navigationBarTitle("Account")
      .navigationBarItems(leading: Text("Cancel"), trailing: Text("Save"))
    }
  }
}

struct AccountDetail_Previews: PreviewProvider {
  static var previews: some View {
    AccountDetail(account: Accounts.expenses)
  }
}
