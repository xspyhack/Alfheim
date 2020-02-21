//
//  StatisticsView.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/13.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
  var onDismiss: () -> Void

  var body: some View {
    NavigationView {
      StatisticList()
        .navigationBarTitle("Statistics")
        .navigationBarItems(leading:
          Button(action: {
            self.onDismiss()
          }) {
            Text("Cancel")
          }
      )
    }
  }
}

#if DEBUG
struct StatisticView_Previews: PreviewProvider {
  static var previews: some View {
    StatisticsView(onDismiss: {})
  }
}
#endif
