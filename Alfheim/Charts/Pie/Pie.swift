//
//  Pie.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/22.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct Pie: View {
  @ObservedObject var data: UnitData

  var slices: [Slice.Data] {
    var slices: [Slice.Data] = []
    var degrees: Double = 0
    let sum = data.points().reduce(0, +)

    for unit in data.units {
      let normalized: Double = Double(unit.value)/Double(sum)
      let startDegrees = degrees
      let endDegress = degrees + (normalized * 360)
      let data = Slice.Data(startDegrees: startDegrees,
                            endDegrees: endDegress,
                            unit: unit,
                            color: .red,
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
  static var random: Color {
    let all: [Color] = [.red, .green, .blue, .orange, .yellow, .pink, .purple]
    return all[Int.random(in: 0..<6)]
  }
}

#if DEBUG
struct Pie_Previews : PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
      Pie(data:  UnitData(points: [8,23,54,32,12,37,7,23,43]))
    }.frame(width: 200, height: 200)
  }
}
#endif
