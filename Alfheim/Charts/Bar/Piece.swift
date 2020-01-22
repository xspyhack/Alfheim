//
//  Piece.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/22.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct Piece: View {
  struct Data: Identifiable {
    var id = UUID()
    var unit: UnitData.Unit
    var normalizedValue: Double
  }

  @State private var fill: Bool = false
  var index: Int
  
  var body: some View {
    Capsule()
//    .trim(from: 0, to: self.fill ? 1 : 0)
    .fill(LinearGradient(gradient: Gradient(colors: [.ah02, .ah03]), startPoint: .bottom, endPoint: .top))
    .scaleEffect(self.fill ? 1 : 0)
    .animation(Animation.spring().delay(Double(self.index) * 0.05))
    .onAppear() {
      self.fill = true
    }
  }
}
