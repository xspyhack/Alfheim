//
//  StatisticList.swift
//  Alfheim
//
//  Created by alex.huo on 2020/2/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct StatisticList: View {
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 24) {
          LineChart(data: [11, 3, 2, 5, 29, 9], title: "Weekly", legend: "this week", value: (10, "%.1f"))
            .frame(width: nil, height: geometry.size.width*16/15)

          PieChart(data: [8,23,54,32,12,37,43], title: "Categories", legend: "7 total")
            .frame(width: nil, height: geometry.size.width*16/15)

          BarChart(data: UnitData(values: [("A", 20), ("B", 30), ("C", 15), ("D", 22)]), title: "Bar", legend: "this week")
            .frame(width: nil, height: geometry.size.width*16/15)
        }
        .padding(20)
      }
    }
  }

  var weeklyCard: some View {
    ZStack {
      LineChart(data: [11, 3, 2, 5, 29, 9], title: "Weekly", legend: "this week", value: (10, "%.1f"))
      HStack {
        Spacer()
        VStack {
          Image(systemName: "arrow.right.circle")
            .padding([.top, .trailing], 20)
          Spacer()
        }
      }
    }
  }
}

struct StatisticList_Previews: PreviewProvider {
  static var previews: some View {
    StatisticList()
  }
}
