//
//  AccountDetailList.swift
//  Alfheim
//
//  Created by alex.huo on 2020/2/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct AccountDetailList: View {
  @EnvironmentObject var store: AppStore
  private var state: AppState {
    store.state
  }

  var body: some View {
    List {
      Section(header: Spacer()) {
        Text(self.state.account.name)
        Text(self.state.account.description)
      }

      Section {
        ForEach(Tagit.allCases) { tag in
          HStack {
            Circle().fill(Color(tagit: tag)).frame(width: 20, height: 20)
            Text(tag.name)
            Spacer()
            if tag == self.state.account.tag {
              Image(systemName: "checkmark")
                .foregroundColor(.blue)
            }
          }
          .contentShape(Rectangle())
          .onTapGesture {
            self.store.dispatch(.account(.toggleTagitSelection(tag)))
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
    AccountDetailList().environmentObject(AppStore())
  }
}
#endif
