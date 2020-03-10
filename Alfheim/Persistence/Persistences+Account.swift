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

    enum Buildin: String {
      case expenses

      var name: String {
        return rawValue.capitalized
      }

      var id: String {
        switch self {
        case .expenses:
          return "_expenses"
        }
      }
    }

    func count(with predicate: NSPredicate? = nil) throws -> Int {
      let fetchRequest: NSFetchRequest<Alfheim.Account> = Alfheim.Account.fetchRequest()
      fetchRequest.predicate = predicate
      return try context.count(for: fetchRequest)
    }

    func empty() throws -> Bool {
      return try count() == 0
    }

    /// Needs executed within a context  in scope
    func all() throws -> [Alfheim.Account] {
      let fetchRequest: NSFetchRequest<Alfheim.Account> = Alfheim.Account.fetchRequest()
      return try fetchRequest.execute()
    }

    /// Without a context in scope
    func empty(block: @escaping (Result<Bool, Error>) -> Void) {
      context.perform {
        do {
          block(.success(try self.all().isEmpty))
        } catch {
          block(.failure(error))
        }
      }
    }

    func loadAll() -> AnyPublisher<[Alfheim.Account], NSError> {
      let fetchRequest: NSFetchRequest<Alfheim.Account> = Alfheim.Account.fetchRequest()
      fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
      return Publishers.FetchedResults(fetchRequest: fetchRequest, context: context)
        .eraseToAnyPublisher()
    }

    func load(with predicate: NSPredicate) -> AnyPublisher<[Alfheim.Account], NSError> {
      let fetchRequest: NSFetchRequest<Alfheim.Account> = Alfheim.Account.fetchRequest()
      fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
      fetchRequest.predicate = predicate
      return Publishers.FetchedResults(fetchRequest: fetchRequest, context: context)
        .eraseToAnyPublisher()
    }

    func load(withName name: String) -> AnyPublisher<Alfheim.Account, NSError> {
      let predicated = NSPredicate(format: "name == %@", name)
      return load(with: predicated).compactMap { $0.first }
        .eraseToAnyPublisher()
    }

    func load(withID id: String) -> AnyPublisher<Alfheim.Account, NSError> {
      let predicated = NSPredicate(format: "id == %@", id)
      return load(with: predicated).compactMap { $0.first }
        .eraseToAnyPublisher()
    }
  }
}
