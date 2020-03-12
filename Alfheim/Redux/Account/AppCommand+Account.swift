//
//  AppCommand+Account.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/12.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppCommands {
  struct UpdateAccountCommand: AppCommand {
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
        try persistence.save()
      } catch {
        print("Update account failed: \(error)")
      }
    }
  }
}
