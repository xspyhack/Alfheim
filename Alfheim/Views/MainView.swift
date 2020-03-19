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

  #if targetEnvironment(macCatalyst)
  var body: some View {
    SplitView()
  }
  #else
  var body: some View {
    OverviewView()
  }
  #endif
}

struct SplitView: View {
  var body: some View {
    Text("Hello split view")
  }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView().environmentObject(AppStore(moc: viewContext))
  }
}
#endif
