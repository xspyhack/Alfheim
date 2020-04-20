//
//  Persistences+Payment.swift
//  Alfheim
//
//  Created by alex.huo on 2020/4/11.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine
import CoreData

extension Persistences {
  struct Payment {
    let context: NSManagedObjectContext

    typealias FetchRequestPublisher = Publishers.FetchRequest<Alfheim.Payment>

    // MARK: - Operators, CURD

    func count(with predicate: NSPredicate? = nil) throws -> Int {
      let fetchRequest: NSFetchRequest<Alfheim.Payment> = Alfheim.Payment.fetchRequest()
      fetchRequest.predicate = predicate
      return try context.count(for: fetchRequest)
    }

    func empty() throws -> Bool {
      return try count() == 0
    }

    /// Needs executed within a context  in scope
    func all() throws -> [Alfheim.Payment] {
      let fetchRequest: NSFetchRequest<Alfheim.Payment> = Alfheim.Payment.fetchRequest()
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

    /// Fetch with predicate, should use in context queue
    func fetch(with predicate: NSPredicate) throws -> [Alfheim.Payment] {
      let fetchRequest: NSFetchRequest<Alfheim.Payment> = Alfheim.Payment.fetchRequest()
      fetchRequest.predicate = predicate
      return try context.fetch(fetchRequest)
    }

    /// Save if has changes, should use in context.perform(_:) block if you need to update results, if not, update notification won't be send to
    /// subscriber, NSFetchedResultsController for example.
    func save() throws {
      guard context.hasChanges else {
        return
      }
      try context.save()
    }

    func payment(withKind kind: Int = -1) -> Alfheim.Payment? {
      let predicate = NSPredicate(format: "kind == %d", kind)
      guard let object = context.registeredObjects(with: predicate).first as? Alfheim.Payment else {
        return nil
      }
      return object
    }

    // MARK: - Publishes

    func fetchRequestPublisher(sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(key: "name", ascending: true)],
                               predicate: NSPredicate? = nil) -> FetchRequestPublisher {
      let fetchRequest: NSFetchRequest<Alfheim.Payment> = Alfheim.Payment.fetchRequest()
      fetchRequest.sortDescriptors = sortDescriptors
      fetchRequest.predicate = predicate
      return Publishers.FetchRequest(fetchRequest: fetchRequest, context: context)
    }

    func fetchAllPublisher() -> AnyPublisher<[Alfheim.Payment], NSError> {
      let sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
      return fetchRequestPublisher(sortDescriptors: sortDescriptors).eraseToAnyPublisher()
    }

    func fetchPublisher(with predicate: NSPredicate) -> AnyPublisher<[Alfheim.Payment], NSError> {
      fetchRequestPublisher(predicate: predicate)
        .eraseToAnyPublisher()
    }

    func fetchPublisher(withName name: String) -> AnyPublisher<Alfheim.Payment, NSError> {
      let predicate = NSPredicate(format: "name == %@", name)
      return fetchPublisher(with: predicate).compactMap { $0.first }
        .eraseToAnyPublisher()
    }

    func fetchPublisher(withKind kind: Int) -> AnyPublisher<Alfheim.Payment, NSError> {
      let predicate = NSPredicate(format: "kind == %d", kind)
      return fetchPublisher(with: predicate).compactMap { $0.first }
        .eraseToAnyPublisher()
    }
  }
}
