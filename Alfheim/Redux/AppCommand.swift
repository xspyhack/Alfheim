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

struct UpdateAccountCommond: AppCommand {
  let account: Alne.Account

  func execute(in store: AppStore) {
    guard let uuid = UUID(uuidString: account.id) else {
      return
    }

    let persistence = Persistences.Account(context: store.context)
    if let object = persistence.account(withID: uuid) {
      object.name = account.name
      object.introduction = account.description
      object.currency = Int16(account.currency.rawValue)
      object.emoji = account.emoji
      object.tag = account.tag.hex
      //object.group = account.group.rawValue // can't update
    } else {
      fatalError("Should not be here!")
      /*
      let object = Alfheim.Account(context: store.context)
      object.id = UUID()
      object.name = account.name
      object.introduction = account.description
      object.currency = Int16(account.currency.rawValue)
      object.emoji = account.emoji
      object.tag = account.tag.hex
      object.group = account.group.rawValue // can't update
      */
    }

    do {
      try Persistences.Account(context: store.context).save()
    } catch {
      print("Update account failed: \(error)")
    }
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
