//
//  StatisticList.swift
//  Alfheim
//
//  Created by alex.huo on 2020/2/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct StatisticList: View {
  @EnvironmentObject var store: AppStore

  private var state: AppState.Shared {
    store.state.shared
  }

  private var transactions: [Alfheim.Transaction] {
    state.periodTransactions
  }

  private var lineData: [Double] {
    transactions.reversed().map { $0.amount }
  }

  private var trend: Double {
    guard !lineData.isEmpty else {
      return 0
    }
    return (lineData.last! - lineData.first!) / lineData.first! * 100.0
  }

  private var pieData: [(String, Double, String)] {
    state.categorizedAmount.map { ($0.key, $0.value, "Unknown") }
  }

  private var barData: Histogram<Dimension> {
    Histogram(values: [("Sat", 0), ("Sun", 30), ("Mon", 18), ("Tue", 28), ("Wed", 36), ("Thu", 23), ("Fri", 16)])
  }

  private static let height: CGFloat = 280

  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 24) {
          BarChart(histogram: self.barData, title: self.state.account.name, legend: "may 01 ~ 07")
            .frame(height: StatisticList.height)

          LineChart(data: self.lineData, title: self.state.account.name, legend: self.state.period.display, value: (self.trend, "%.1f"))
            .frame(height: StatisticList.height)

          PieChart(data: self.pieData, title: "Categories", legend: "\(self.pieData.count) total")
            .frame(height: StatisticList.height)

          Text("Footer")
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
    StatisticList().environmentObject(AppStore(moc: viewContext))
  }
}
