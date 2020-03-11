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

    typealias FetchedResultsPublisher = Publishers.FetchedResults<Alfheim.Account>

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

    // MARK: - Operators, CURD

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

    /// Save if has changes
    func save() throws {
      guard context.hasChanges else {
        return
      }
      try context.save()
    }

    // MARK: - Publishes

    func fetchResultsPublisher(sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(key: "name", ascending: true)],
                               predicate: NSPredicate? = nil) -> FetchedResultsPublisher {
      let fetchRequest: NSFetchRequest<Alfheim.Account> = Alfheim.Account.fetchRequest()
      fetchRequest.sortDescriptors = sortDescriptors
      fetchRequest.predicate = predicate
      return Publishers.FetchedResults(fetchRequest: fetchRequest, context: context)
    }

    func fetchAllPublisher() -> AnyPublisher<[Alfheim.Account], NSError> {
      let sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
      return fetchResultsPublisher(sortDescriptors: sortDescriptors).eraseToAnyPublisher()
    }

    func fetchPublisher(with predicate: NSPredicate) -> AnyPublisher<[Alfheim.Account], NSError> {
      fetchResultsPublisher(predicate: predicate)
        .eraseToAnyPublisher()
    }

    func fetchPublisher(withName name: String) -> AnyPublisher<Alfheim.Account, NSError> {
      let predicated = NSPredicate(format: "name == %@", name)
      return fetchPublisher(with: predicated).compactMap { $0.first }
        .eraseToAnyPublisher()
    }

    func fetchPublisher(withID id: String) -> AnyPublisher<Alfheim.Account, NSError> {
      let predicated = NSPredicate(format: "id == %@", id)
      return fetchPublisher(with: predicated).compactMap { $0.first }
        .eraseToAnyPublisher()
    }
  }
}
