//
//  OverviewView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct OverviewView: View {
  #if targetEnvironment(macCatalyst)
  var body: some View {
      SplitView()
  }
  #else
  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ScrollView(.vertical, showsIndicators: false) {
          VStack(spacing: 24) {
            BarChart(data: UnitData(values: [("A", 20), ("B", 30), ("C", 15), ("D", 22)]), title: "Bar", legend: "this week")
              .frame(width: nil, height: geometry.size.width*16/15, alignment: .center)

            LineChart(data: [11, 3, 2, 5, 29, 9], title: "Weekly", legend: "this week", value: (10, "%.1f"))
              .frame(width: nil, height: geometry.size.width*16/15, alignment: .center)

            PieChart(data: [8,23,54,32,12,37,43], title: "Categories", legend: "7 total")
              .frame(width: nil, height: geometry.size.width*16/15, alignment: .center)
          }
          .padding(20)
        }
      }
      .navigationBarTitle("Journals")
      .navigationBarItems(trailing:
        Button("New") {

        }
      )
    }
  }
  #endif
}

struct SplitView: View {
  var body: some View {
    Text("Hello split view")
  }
}

struct OverviewView_Previews: PreviewProvider {
  static var previews: some View {
    OverviewView().environment(\.colorScheme, .dark)
  }
}
