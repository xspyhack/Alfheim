//
//  Bar.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/22.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct Bar: View {
  @ObservedObject var data: UnitData

  var pieces: [Piece.Data] {
    let max = data.points().max() ?? 0
    let min = data.points().min() ?? 0
    var pieces: [Piece.Data] = []
    let delta = 0.15 * (max - min)
    for unit in data.units {
      let amount: Double = Double(unit.value - (min - delta))/Double(max - (min - delta))
      let data = Piece.Data(unit: unit, amount: amount)
      pieces.append(data)
    }
    return pieces
  }

  var body: some View {
    GeometryReader { geometry in
      HStack(alignment: .bottom, spacing: CGFloat(geometry.size.width) / CGFloat(4 * self.pieces.count - 1)) {
        ForEach(0..<self.pieces.count) { index in
          self.piece(at: index, height: geometry.size.height)
        }
      }
    }
  }

  func piece(at index: Int, height: CGFloat) -> some View {
    let piece = pieces[index]
    return Piece(index: index)
      .frame(height: CGFloat(piece.amount) * height)
  }
}

#if DEBUG
struct Bar_Previews : PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
//      Bar(data: UnitData(points: [20, 6, 4, 0, 4, 6, 10]))
//      Bar(data: UnitData(points: [-2, 0, 2, 4, 6, 8, 10]))
      Bar(data: UnitData(points: [-2, 0, 1, 3, 4, 5, 6]))
    }.frame(width: 200, height: 200)
  }
}
#endif
