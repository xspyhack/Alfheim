//
//  Emojis.swift
//  Alfheim
//
//  Created by alex.huo on 2020/5/5.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

func loadEmojis() -> [String] {
  guard let fileURL = Bundle.main.url(forResource: "emojis", withExtension: "json") else {
    return []
  }

  guard let string = try? String(contentsOfFile: fileURL.path) else {
    return []
  }

  var emojis: [String] = []
  for index in 0..<string.count - 1 {
      let emoji = string[string.index(string.startIndex, offsetBy: index)]
      emojis.append(String(emoji))
  }

  return emojis
}
