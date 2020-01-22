//
//  Slice.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/22.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct Slice: View {
  struct Data: Identifiable {
    var id = UUID()
    var startDegrees: Double
    var endDegrees: Double
    var unit: UnitData.Unit
    var color: Color
    var normalizedValue: Double
  }

  @State private var fill: Bool = false

  var startDegrees: Double
  var endDegrees: Double
  var index: Int
  var color: Color

  var sector: Sector {
    Sector(startDegrees: startDegrees, endDegrees: endDegrees)
  }

  var body: some View {
    sector
      .fill()
      .foregroundColor(Color.random)
      .overlay(sector.stroke(Color.white, lineWidth: 2))
      .scaleEffect(self.fill ? 1 : 0)
      .animation(Animation.spring().delay(Double(self.index) * 0.05))
      .onAppear() {
        self.fill.toggle()
      }
  }
}

#if DEBUG
struct Slice_Previews : PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
      Slice(startDegrees: 0.0, endDegrees: 120.0, index: 0, color: .pink)
    }.frame(width: 200, height: 200)
  }
}
#endif
