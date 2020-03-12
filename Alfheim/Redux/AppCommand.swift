//
//  AppCommand.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine

protocol AppCommand {
  func execute(in store: AppStore)
}

enum AppCommands {
}

class SubscriptionToken {
  var cancellable: AnyCancellable?
  func unseal() { cancellable = nil }
}

extension AnyCancellable {
  func seal(in token: SubscriptionToken) {
    token.cancellable = self
  }
}
