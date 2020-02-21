//
//  AccountDetailList.swift
//  Alfheim
//
//  Created by alex.huo on 2020/2/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct AccountDetailList: View {
  var account: Account

  var body: some View {
    List {
      Section(header: Spacer()) {
        Text(account.name)
        Text(account.description)
//        Text(account.emoji ?? "")
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
  }
}

#if DEBUG
struct AccountDetailList_Previews: PreviewProvider {
  static var previews: some View {
    AccountDetailList(account: Accounts.expenses)
  }
}
#endif
