//
//  Pie.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/22.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct Pie: View {
  @ObservedObject var data: Histogram<LabeledUnit>

  var slices: [Slice.Data] {
    var slices: [Slice.Data] = []
    var degrees: Double = 0
    let sum = data.points().reduce(0, +)

    for (index, unit) in data.units.enumerated() {
      let normalized: Double = Double(unit.value)/Double(sum)
      let startDegrees = degrees
      let endDegress = degrees + (normalized * 360)
      let data = Slice.Data(startDegrees: startDegrees,
                            endDegrees: endDegress,
                            unit: unit,
                            color: Color.color(at: index),
                            normalizedValue: normalized)
      slices.append(data)
      degrees = endDegress
    }
    return slices
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        ForEach(0..<self.slices.count) { index in
          self.slice(at: index)
        }
      }
    }
  }

  func slice(at index: Int) -> Slice {
    let data = slices[index]
    return Slice(startDegrees: data.startDegrees,
                 endDegrees: data.endDegrees,
                 index: index,
                 color: data.color)
  }
}

extension Color {
  static func color(at index: Int) -> Color {
    let all: [Color] = [.red, .green, .blue, .orange, .yellow, .pink, .purple]
    let i = index % all.count
    return all[i]
  }
}

#if DEBUG
struct Pie_Previews : PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
      Pie(data:  Histogram(values: [("Mon", 8, "a"), ("Tue", 18, "b"), ("Wed", 28, "c"), ("Thu", 12, "d"), ("Fri", 16, "e"), ("Sat", 22, "f"), ("Sun", 20, "g")]))
    }.frame(width: 200, height: 200)
  }
}
#endif
