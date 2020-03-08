//
//  Persistences+Transaction.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/8.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine
import CoreData

extension Persistences {
  struct Transaction {
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
      self.context = context
    }

    func loadAll() -> AnyPublisher<[Alfheim.Transaction], NSError> {
      let fetchRequest: NSFetchRequest<Alfheim.Transaction> = Alfheim.Transaction.fetchRequest()
      fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
      return Publishers.FetchedResults(fetchRequest: fetchRequest, context: context)
        .eraseToAnyPublisher()
    }

    func load(with predicate: NSPredicate) -> AnyPublisher<[Alfheim.Transaction], NSError> {
      let fetchRequest = NSFetchRequest<Alfheim.Transaction>(entityName: "Transaction")
      fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
      fetchRequest.predicate = predicate
      return Publishers.FetchedResults(fetchRequest: fetchRequest, context: context)
        .eraseToAnyPublisher()
    }
  }
}
