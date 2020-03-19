//
//  UnitData.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

class UnitData: ObservableObject {
  typealias Unit = (name: String, value: Double)
  @Published var units: [Unit] = [Unit]()

  var valuesGiven: Bool = false

  init(points: [Double]) {
    self.units = points.map { ("", $0) }
  }

  init(values: [(String, Int)]) {
    self.units = values.map { ($0.0, Double($0.1)) }
    self.valuesGiven = true
  }

  init(values: [(String, Double)]) {
    self.units = values.map { ($0.0, $0.1) }
    self.valuesGiven = true
  }

  func points() -> [Double] {
    units.map { $0.1 }
  }

  func values() -> [Double] {
    units.map { $0.1 }
  }
}
