//
//  PieChart.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/22.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct PieChart: View {
  @ObservedObject var histogram: Histogram<LabeledUnit>
  var title: String
  var legend: String?
  var symbol: String?

  private var sum: Double {
    histogram.points().reduce(0, +)
  }

  init(data: [(String, Double, String)],
       title: String,
       legend: String? = nil,
       symbol: String? = nil) {
    self.init(histogram: Histogram(values: data),
              title: title,
              legend: legend,
              symbol: symbol)
  }

  init(data: [(String, Int, String)],
       title: String,
       legend: String? = nil,
       symbol: String? = nil) {
    self.init(data: data.map { ($0, Double($1), $2) },
              title: title,
              legend: legend,
              symbol: symbol)
  }

  init(histogram: Histogram<LabeledUnit>,
       title: String,
       legend: String? = nil,
       symbol: String? = nil) {
    self.histogram = histogram
    self.title = title
    self.legend = legend
    self.symbol = symbol
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

      Pie(histogram: self.histogram)
        .aspectRatio(1.0, contentMode: .fit)

      if self.histogram.isNamed {
        VStack(alignment: .leading, spacing: 8) {
          ForEach(0..<self.histogram.units.count) { index in
            HStack {
              HStack {
                Text(self.unit(at: index).symbol.capitalized)
                  .font(.system(size: 16, weight: .medium))
                Spacer()
              }
              .frame(width: 86)
              VStack(alignment: .leading, spacing: 2) {
                HStack {
                  Text(self.unit(at: index).label).font(.system(size: 14))
                  Text("\(self.percent(at: index), specifier: "%.1f")%")
                    .font(.system(size: 12))
                    .foregroundColor(Color.secondary)
                  Spacer()
                }
                ZStack(alignment: .leading) {
                  GeometryReader { proxy in
                    Capsule().fill(Color(.secondarySystemBackground))
                      .padding(.vertical, 2)
                    Capsule().fill(Color.color(at: index))
                      .frame(width: CGFloat(self.percent(at: index)) * proxy.size.width)
                    .padding(.vertical, 2)
                  }
                }
              }

              Spacer()
              HStack {
                Spacer()
                Text("\(self.symbol ?? "")\(self.unit(at: index).value, specifier: "%.1f")")
                  .font(.system(size: 14))
              }
              .frame(width: 72)
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

  private func unit(at index: Int) -> LabeledUnit {
    histogram.units[index]
  }
}

#if DEBUG
struct PieChart_Previews : PreviewProvider {
  static var previews: some View {
    ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
      ScrollView {
        PieChart(data: [("Sat", 0, "A"), ("Sun", 30, "A"), ("Mon", 18, "A"), ("Tue", 28, "A"), ("Wed", 36, "A"), ("Thu", 23, "A"), ("Fri", 16, "A")], title: "Pie", legend: "accounts", symbol: "$")
       }
      .environment(\.colorScheme, colorScheme)
      .previewDisplayName("\(colorScheme)")
      .padding()
    }
    .background(Color(.systemBackground))
  }
}
#endif
