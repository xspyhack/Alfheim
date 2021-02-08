//
//  AppEnvironment.swift
//  Alfheim
//
//  Created by alex.huo on 2021/2/6.
//  Copyright © 2021 blessingsoft. All rights reserved.
//

import Foundation
import CoreData

struct AppEnvironment {
  let decoder = JSONDecoder()
  let encoder = JSONEncoder()
  let file = FileManager.default
  let queue = DispatchQueue.main

  var context: NSManagedObjectContext?
}

extension AppEnvironment {
  static let `default` = AppEnvironment()
}

enum AppEnvironments {}
