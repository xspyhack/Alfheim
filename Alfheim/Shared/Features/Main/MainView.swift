//
//  MainView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/19.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct MainView: View {
  @EnvironmentObject var store: AppStore
  #if os(iOS)
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  #endif

  var body: some View {
//    #if os(iOS)
//    if horizontalSizeClass == .compact {
//      OverviewView()
//    } else {
//      SidebarNavigation()
//    }
//    #else
    SidebarNavigation()
//    #endif
  }
}

struct SidebarNavigation: View {
  #if os(iOS)
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  #endif

  @EnvironmentObject var store: AppStore

  var body: some View {
    NavigationView {
      Sidebar(selectedAccount: Alne.Accounts.expenses)

      //OverviewView(account: nil)

      // detail view in iPad
      Text("Sidebar navigation")
    }
  }
}

struct Sidebar: View {
  @EnvironmentObject var store: AppStore

  private var state: AppState {
    store.state
  }

  @State var selectedAccount: Alne.Account?

  var body: some View {
    List(selection: $selectedAccount) {
      ForEach(state.account.accounts) { account in
        NavigationLink(
          destination: OverviewView()
            .environmentObject(
              store.derived(
                state: { _ in AppState.Overview(account: account) },
                action: AppAction.overview
              )
            )
        ) {
          Label(account.name, systemImage: "folder.circle")
        }
      }
    }
    .listStyle(SidebarListStyle())
    .navigationBarTitle("Clic")
    .navigationBarItems(
      trailing: Button(action: {
        //store.dispatch(.account(.cleanup))
      }) {
        Image(systemName: "gear")
      }
    )
  }
}

#if DEBUG
//struct MainView_Previews: PreviewProvider {
//  static var previews: some View {
//    MainView().environmentObject(AppStore(moc: viewContext))
//  }
//}
#endif
