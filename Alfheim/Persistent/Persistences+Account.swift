//
//  Persistences+Account.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/8.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine
import CoreData

extension Persistences {
  struct Account {
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
      self.context = context
    }

    func loadAll() -> AnyPublisher<[Alfheim.Account], NSError> {
      let fetchRequest: NSFetchRequest<Alfheim.Account> = Alfheim.Account.fetchRequest()
      fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
      return Publishers.FetchedResults(fetchRequest: fetchRequest, context: context)
        .eraseToAnyPublisher()
    }

    func load(with predicate: NSPredicate) -> AnyPublisher<[Alfheim.Account], NSError> {
      let fetchRequest = NSFetchRequest<Alfheim.Account>(entityName: "Account")
      fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
      fetchRequest.predicate = predicate
      return Publishers.FetchedResults(fetchRequest: fetchRequest, context: context)
        .eraseToAnyPublisher()
    }

    func load(with name: String) -> AnyPublisher<Alfheim.Account, NSError> {
      let fetchRequest = NSFetchRequest<Alfheim.Account>(entityName: "Account")
      fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
      fetchRequest.predicate = NSPredicate(format: "name == %@", name)
      return Publishers.FetchedResults(fetchRequest: fetchRequest, context: context)
        .compactMap { $0.first }
        .eraseToAnyPublisher()
    }

    func load(withID id: String) -> AnyPublisher<Alfheim.Account, NSError> {
      let predicated = NSPredicate(format: "id == %@", id)
      return load(with: predicated).compactMap { $0.first }
        .eraseToAnyPublisher()
    }
  }
}
