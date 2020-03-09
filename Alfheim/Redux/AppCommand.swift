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

struct LoadTransactionCommand: AppCommand {
  func execute(in store: AppStore) {
    let token = SubscriptionToken()
    Persistences.Transaction(context: store.context)
      .loadAll()
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          print("Load transaction failured: \(error)")
        case .finished:
          print("Load transactoin finished")
        }
      }, receiveValue: { transactions in
        print("Transactions \(transactions)")
        
      })
      .seal(in: token)
  }
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
