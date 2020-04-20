//
//  AppCommand+Payment.swift
//  Alfheim
//
//  Created by alex.huo on 2020/4/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppCommands {
  struct LoadPaymentCommand: AppCommand {
    let kind: Int

    func execute(in store: AppStore) {
      let persistence = Persistences.Payment(context: store.context)
      if let payment = persistence.payment(withKind: kind) {
        store.dispatch(.payment(.loadPaymentDone(payment)))
      } else {
        let token = SubscriptionToken()
        persistence.fetchPublisher(withKind: kind)
          .sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
              print("error")
            }
            token.unseal()
          }, receiveValue: { payment in
            store.dispatch(.payment(.loadPaymentDone(payment)))
          })
          .seal(in: token)
      }
    }
  }
}
