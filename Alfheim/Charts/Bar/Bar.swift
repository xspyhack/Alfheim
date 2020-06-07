//
//  Bar.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/22.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct Bar: View {
  @ObservedObject var histogram: Histogram<Dimension>

  var pieces: [Piece.Data] {
    let max = histogram.points().max() ?? 0
    let min = histogram.points().min() ?? 0
    var pieces: [Piece.Data] = []
    let delta = min == 0 ? 0 : 0.15 * (max - min)
    for unit in histogram.units {
      let amount: Double = Double(unit.value - (min - delta))/Double(max - (min - delta))
      let data = Piece.Data(unit: unit, amount: amount)
      pieces.append(data)
    }
    return pieces
  }

  var body: some View {
    GeometryReader { geometry in
      HStack(alignment: .bottom, spacing: CGFloat(geometry.size.width) / CGFloat(3 * (self.pieces.count - 1))) {
        ForEach(0..<self.pieces.count) { index in
          VStack(spacing: 4) {
            ZStack(alignment: .bottom) {
              Capsule().fill(Color(.secondarySystemBackground))
              self.piece(at: index, size: geometry.size)
            }
          }
        }
      }
    }
  }

  func piece(at index: Int, size: CGSize) -> some View {
    let piece = pieces[index]
    let adjust: CGFloat
    if piece.amount > 0.0 && piece.amount < 1.0 {
      let gap = CGFloat(size.width) / CGFloat(3 * (self.pieces.count - 1))
      let width = (size.width - CGFloat((histogram.points().count - 1)) * gap) / CGFloat(histogram.points().count)
      adjust = width
    } else {
      adjust = 0.0
    }
    return Piece(index: index)
      .frame(height: CGFloat(piece.amount) * size.height + adjust)
  }
}

#if DEBUG
struct Bar_Previews : PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
//      Bar(data: UnitData(points: [20, 6, 4, 0, 4, 6, 10]))
//      Bar(data: UnitData(points: [-2, 0, 2, 4, 6, 8, 10]))
      Bar(histogram: Histogram<Dimension>(points: [-2, 0, 1, 3, 4, 5, 6]))
    }.frame(width: 200, height: 200)
  }
}
#endif
