//
//  ChartsView.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/5/23.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct ChartsView: View {
  var body: some View {
    VStack {
      BarChart(data: UnitData(values: [("Sat", 0), ("Sun", 30), ("Mon", 18), ("Tue", 28), ("Wed", 36), ("Thu", 23), ("Fri", 16)]), title: "Weekly")
        .frame(height: 280)
    }
    .padding()
  }
}

#if DEBUG
struct ChartsView_Previews: PreviewProvider {
  static var previews: some View {
    ChartsView()
  }
}
#endif
