//
//  Array+Alfheim.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/15.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension Array {
  /// RangeReplaceableCollection.remove(atOffsets offsets: IndexSet)
  func elements(atOffsets offsets: IndexSet) -> [Element] {
    enumerated()
      .filter { offsets.contains($0.offset) }
      .map { $0.element }
  }
}
