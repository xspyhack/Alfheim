//
//  PieChart.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/22.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct PieChart: View {
  @ObservedObject var data: UnitData
  var title: String
  var legend: String?

  private var sum: Double {
    data.points().reduce(0, +)
  }

  init(data: UnitData, title: String, legend: String? = nil) {
    self.data = data
    self.title = title
    self.legend = legend
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        VStack(alignment: .leading, spacing: 8) {
          Text(self.title).font(.system(size: 24, weight: .semibold))
            .foregroundColor(.primary)
          if self.legend != nil {
            Text(self.legend!).font(.callout)
              .foregroundColor(.secondary)
              .padding(.leading, 2)
          }
        }
        Spacer()
        Image(systemName: "chart.pie.fill")
      }
      .padding(.bottom, 24)

      Pie(data: self.data)
        .aspectRatio(1.0, contentMode: .fit)

      if self.data.isNamed {
        VStack(alignment: .leading, spacing: 2) {
          ForEach(0..<self.data.units.count) { index in
            HStack {
              HStack {
                Text(self.unit(at: index).name)
                Spacer()
              }
              .frame(width: 50)
              ZStack(alignment: .leading) {
                GeometryReader { proxy in
                  Capsule().fill(Color(.secondarySystemBackground))
                    .padding(.vertical, 12)
                  HStack {
                    Capsule().fill(Color.color(at: index))
                      .padding(.vertical, 12)
                      .frame(width: CGFloat(self.percent(at: index)) * proxy.size.width)
                    Text("\(self.percent(at: index), specifier: "%.1f")%")
                      .font(.system(size: 10))
                  }
                }
              }

              Spacer()
              HStack {
                Spacer()
                Text("$\(self.unit(at: index).value, specifier: "%.1f")")
                  .font(.system(size: 16))
              }
              .frame(width: 60)
            }
            .frame(height: 36)
          }
        }
        .padding(.top, 16)
      }
    }
    .padding(20)
    .background(
      RoundedRectangle(cornerRadius: 20)
        .fill(Color(.systemBackground))
        .shadow(color: Color.shadow, radius: 8)
    )
  }

  private func percent(at index: Int) -> Double {
    unit(at: index).value/sum
  }

  private func unit(at index: Int) -> UnitData.Unit {
    data.units[index]
  }

  private func display(of value: Double) -> String {
    "$\(String(format: "%.1f", value))"
  }
}

#if DEBUG
struct PieChart_Previews : PreviewProvider {
  static var previews: some View {
    ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
      ScrollView {
        PieChart(data: UnitData(values: [("Sat", 0), ("Sun", 30), ("Mon", 18), ("Tue", 28), ("Wed", 36), ("Thu", 23), ("Fri", 16)]), title: "Pie", legend: "accounts")
       }
      .environment(\.colorScheme, colorScheme)
      .previewDisplayName("\(colorScheme)")
      .padding()
    }
    .background(Color(.systemBackground))
  }
}
#endif
