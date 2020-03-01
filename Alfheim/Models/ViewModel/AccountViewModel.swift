//
//  AccountViewModel.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/1.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

struct AccountViewModel {
  var account: Account

  var name: String { account.name }
  var description: String { account.description }
  var tag: Tagit { account.tag }
}
