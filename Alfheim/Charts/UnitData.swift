//
//  UnitData.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

class UnitData: ObservableObject {
  @Published var units: [(String, Double)] = [(String, Double)]()
  var valuesGiven: Bool = false

  init<N: BinaryFloatingPoint>(points: [N]) {
    self.units = points.map { ("", Double($0)) }
  }

  init<N: BinaryInteger>(values: [(String, N)]) {
    self.units = values.map { ($0.0, Double($0.1)) }
    self.valuesGiven = true
  }

  init<N: BinaryFloatingPoint>(values: [(String, N)]) {
    self.units = values.map { ($0.0, Double($0.1)) }
    self.valuesGiven = true
  }

  init<N: BinaryInteger>(numberValues: [(N, N)]) {
    self.units = numberValues.map { (String($0.0), Double($0.1)) }
    self.valuesGiven = true
  }

  init<N: BinaryFloatingPoint & LosslessStringConvertible>(numberValues: [(N, N)]) {
    self.units = numberValues.map { (String($0.0), Double($0.1)) }
    self.valuesGiven = true
  }

  func points() -> [Double] {
    units.map { $0.1 }
  }
}
