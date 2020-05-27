//
//  BarChart.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/22.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct BarChart: View {
  @ObservedObject var data: Histogram<Dimension>
  var title: String
  var legend: String?

  private var specifier: String

  @State private var touchLocation: CGPoint = .zero
  @State private var currentValue: Value = 0
  @State private var showsValue: Bool = false

  init(data: Histogram<Dimension>, title: String, legend: String? = nil, specifier: String = "%.1f") {
    self.data = data
    self.title = title
    self.legend = legend
    self.specifier = specifier
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .center) {
        RoundedRectangle(cornerRadius: 20)
          .fill(Color.ah00)
          .shadow(color: Color.shadow, radius: 8)
        VStack(alignment: .leading, spacing: 2) {
          HStack {
            VStack(alignment: .leading, spacing: 8) {
              if !self.showsValue {
                Text(self.title)
                  .font(.system(size: 24, weight: .semibold))
                  .foregroundColor(.primary)

                if self.legend != nil {
                  Text(self.legend!).font(.callout)
                    .foregroundColor(.secondary)
                }
              } else {
                Text("\(self.currentValue, specifier: self.specifier)")
                  .font(.system(size: 41, weight: .bold))
                  .foregroundColor(.primary)
              }
            }
            Spacer()
            Image(systemName: "waveform.path.ecg")
          }
          .transition(.opacity)
          .animation(.easeIn(duration: 0.1))
          .frame(height: 54, alignment: .center)
          .padding(.bottom, 24)

          GeometryReader { geometry in
            Bar(data: self.data)
          }
          .gesture(DragGesture()
            .onChanged { value in
              self.touchLocation = value.location
              self.showsValue = true
              self.handleTouch(to: value.location, in: geometry.frame(in: .local).size)
            }
            .onEnded { value in
              self.showsValue = false
            }
          )

          if self.data.isNamed {
            GeometryReader { geometry in
              HStack(alignment: .bottom, spacing: CGFloat(geometry.size.width) / CGFloat(3 * (self.data.units.count - 1))) {
                ForEach(self.data.units, id: \.symbol) { unit in
                  Text(unit.symbol)
                    .font(.system(size: 12))
                    .frame(maxWidth: .infinity)
                }
              }
            }
            .frame(height: 24)
            .padding(.top, 4)
          }
        }
        .padding(20)
      }
    }
  }
}

extension BarChart {
  @discardableResult
  private func handleTouch(to location: CGPoint, in frame: CGSize) -> Int {
    let points = data.points()
    let step = frame.width / CGFloat(points.count)
    let idx = max(0, min(data.points().count - 1, Int(location.x / step)))
    self.currentValue = points[idx]
    return idx
  }
}

#if DEBUG
struct BarChart_Previews : PreviewProvider {
  static var previews: some View {
//    ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
      GeometryReader { geometry in
        BarChart(data: Histogram<Dimension>(values: [("A", 20), ("B", 30), ("C", 15), ("D", 22)]), title: "Bar", legend: "chart")
      }
//      .environment(\.colorScheme, colorScheme)
//      .previewDisplayName("\(colorScheme)")
//    }
//    .previewLayout(.sizeThatFits)
//    .background(Color(.systemBackground))
//    .padding(10)
  }
}
#endif
