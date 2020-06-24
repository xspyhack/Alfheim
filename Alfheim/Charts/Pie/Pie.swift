//
//  Pie.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/22.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct Pie: View {
  @ObservedObject var histogram: Histogram<LabeledUnit>

  var slices: [Slice.Data] {
    var slices: [Slice.Data] = []
    var degrees: Double = 0
    let sum = histogram.points().reduce(0, +)

    for (index, unit) in histogram.units.enumerated() {
      let normalized: Double = Double(unit.value)/Double(sum)
      let startDegrees = degrees
      let endDegress = degrees + (normalized * 360)
      let data = Slice.Data(startDegrees: startDegrees,
                            endDegrees: endDegress,
                            unit: unit,
                            color: Color.with(symbol: unit.symbol, at: index),
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
  
  static func with(label: String, at index: Int) -> Color {
    return with(label: label) ?? color(at: index)
  }
  
  static func with(symbol: String, at index: Int) -> Color {
    return with(symbol: symbol) ?? color(at: index)
  }
  
  static func with(label: String) -> Color? {
    switch label {
    case "🍔":
      return Color("Orange")
    case "🥤":
      return Color("Teal")
    case "🍎":
      return Color("Red")
    case "👔":
      return Color("Blue")
    case "🏠":
      return Color("Lime")
    case "🤷‍♂️":
      return Color("Cyan")
    case "🚘":
      return Color("Indigo")
    case "🌐":
      return Color("Yellow")
    case "👀":
      return Color("Grape")
    default:
      return nil
    }
  }
  
  static func with(symbol: String) -> Color? {
    switch symbol.lowercased() {
    case "food":
      return Color("Orange")
    case "drink":
      return Color("Teal")
    case "fruit":
      return Color("Red")
    case "clothes":
      return Color("Blue")
    case "household":
      return Color("Lime")
    case "personal":
      return Color("Cyan")
    case "transportation":
      return Color("Indigo")
    case "services":
      return Color("Yellow")
    case "uncleared":
      return Color("Grape")
    default:
      return nil
    }
  }
}

#if DEBUG
struct Pie_Previews : PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
      Pie(histogram:  Histogram(values: [("Mon", 8, "a"), ("Tue", 18, "b"), ("Wed", 28, "c"), ("Thu", 12, "d"), ("Fri", 16, "e"), ("Sat", 22, "f"), ("Sun", 20, "g")]))
    }.frame(width: 200, height: 200)
  }
}
#endif
