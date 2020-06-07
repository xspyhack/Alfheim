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
    state.categorized
      .map { category, viewModels in
        (category, viewModels.reduce(0.0, { $0 + $1.amount }), viewModels.first!.catemoji.emoji)
      }
  }

  private var barData: [(String, Double)] {
    state.labeledAmount(with: state.period)
  }

  private var barLegend: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd"
    let range = state.range(with: state.period)
    return "\(formatter.string(from: range.lowerBound))-\(formatter.string(from: range.upperBound))"
  }

  private static let height: CGFloat = 280

  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 24) {
          BarChart(data: self.barData, title: self.state.account.name, legend: self.barLegend)
            .frame(height: StatisticList.height)

          LineChart(data: self.lineData, title: self.state.account.name, legend: self.state.period.display, value: (self.trend, "%.1f"))
            .frame(height: StatisticList.height)

          PieChart(data: self.pieData, title: "Categories", legend: "\(self.pieData.count) total", symbol: self.state.account.currency.symbol)
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
