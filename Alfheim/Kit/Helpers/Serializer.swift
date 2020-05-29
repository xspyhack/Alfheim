//
//  Importer.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/5/29.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

/// Import transactions
struct Serializer {

  func handle(url: URL) -> Bool {
    guard url.isFileURL else {
      return false
    }

    try? decode(from: url)
    return true
  }

  func decode(from fileURL: URL) throws {
    guard let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.xspyhack.Alfheim") else {
      return
    }
    let directory = container.appendingPathComponent("shared", isDirectory: true)

    let contents = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)

    for url in contents {
      let data = try Data(contentsOf: url)
      let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)

      if let transactions = json as? [[String: Any]] {
        for transaction in transactions {
          let amount = transaction["amount"]
          let date = transaction["date"]
          let notes = transaction["notes"]
          let currency = transaction["currency"]
          let payment = transaction["payment"]
        }
      }
    }
  }
}
