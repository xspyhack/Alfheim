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
    ScrollView {
      VStack(spacing: 32) {
        BarChart(data: self.data, title: "Week", legend: "Chart")
          .frame(height: 280)

        LineChart(data: data.values(), title: "Month", legend: "Chart", value: (10.0, "%.1f"))
          .frame(height: 280)

        PieChart(data: data, title: "Categories", legend: "7 total")

        ForEach(0..<20) { index in
          Text("Hello \(index)")
        }
      }
      .padding()
    }
  }

  let data = UnitData(values: [("Sat", 0), ("Sun", 30), ("Mon", 18), ("Tue", 28), ("Wed", 36), ("Thu", 23), ("Fri", 16)])
}

#if DEBUG
struct ChartsView_Previews: PreviewProvider {
  static var previews: some View {
    ChartsView()
  }
}
#endif
