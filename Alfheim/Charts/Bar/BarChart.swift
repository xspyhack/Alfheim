//
//  BarChart.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/22.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct BarChart: View {
  var body: some View {
    Bar(data: UnitData(points: [20, 6, 4, 2, 4, 6, 0]))
  }
}

#if DEBUG
struct BarChart_Previews : PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
      BarChart()
    }.frame(width: 200, height: 200)
  }
}
#endif
