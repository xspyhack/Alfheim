//
//  Catemoji.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/1.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

protocol CategoryEmojiRepresentable {
  var category: Category { get }
  var emoji: String { get }
}

extension Alne {
  struct Catemoji: CategoryEmojiRepresentable {
    let category: Category
    let emoji: String

    static let uncleared = Catemoji(category: .uncleared, emoji: Alne.Uncleared.uncleared.emoji)
  }
}

extension Alne.Catemoji: Hashable {}

extension Alne {
  enum Food: String, CaseIterable, CategoryEmojiRepresentable {
    case groceries = "🛒"
    case eating = "🍽"
    case snacks = "🍟"
    case others = "🍔"

    var emoji: String {
      rawValue
    }

    var category: Category {
      .food
    }
  }

  enum Fruit: String, CaseIterable, CategoryEmojiRepresentable {
    case apple = "🍎"
    case banana = "🍌"
    case grapes = "🍇"
    case cherries = "🍒"
    case others = "🍓"

    var emoji: String {
      rawValue
    }

    var category: Category {
      .fruit
    }
  }

  enum Drink: String, CaseIterable, CategoryEmojiRepresentable {
    case beer = "🍻"
    case milk = "🥛"
    case tea = "🥤"
    case wine = "🍷"
    case others = "🍹"

    var emoji: String {
      rawValue
    }

    var category: Category {
      .drink
    }
  }

  enum Clothes: String, CaseIterable, CategoryEmojiRepresentable {
    case shirt = "👕"
    case pants = "👖"
    case sock = "🧦"
    case coat = "🧥"
    case skirt = "👗"
    case others = "👔"

    var emoji: String {
      rawValue
    }

    var category: Category {
      .clothes
    }
  }

  enum Household: String, CaseIterable, CategoryEmojiRepresentable {
    case goods = "🧺"
    case love = "👩‍❤️‍👨"
    case travel = "🏖"
    case object = "💡"
    case others = "🏠"

    var emoji: String {
      rawValue
    }

    var category: Category {
      .household
    }
  }

  enum Personal: String, CaseIterable, CategoryEmojiRepresentable {
    case health = "💊"
    case privacy = "🔏"
    case services = "🌐"
    case others = "🤷‍♂️"

    var emoji: String {
      rawValue
    }

    var category: Category {
      .personal
    }
  }

  enum Transportation: String, CaseIterable, CategoryEmojiRepresentable {
    case taxi = "🚕"
    case car = "🚘"
    case airplane = "✈️"
    case bus = "🚙"
    case metro = "🚇"
    case train = "🚄"
    case boat = "🛳"
    case others = "🚲"

    var emoji: String {
      rawValue
    }

    var category: Category {
      .transportation
    }
  }

  enum Uncleared: String, CaseIterable, CategoryEmojiRepresentable {
    case uncleared = "🧚‍♀️"

    var emoji: String {
      rawValue
    }

    var category: Category {
      .uncleared
    }
  }
}

enum Category: String, CaseIterable {
  case food
  case drink
  case fruit
  case clothes
  case household
  case personal
  case transportation
  case services
  case uncleared

  var name: String {
    rawValue
  }

  var text: String {
    switch self {
    case .food:
      return "🍔"
    case .drink:
      return "🥤"
    case .fruit:
      return "🍎"
    case .clothes:
      return "👔"
    case .household:
      return "🏠"
    case .personal:
      return "🤷‍♂️"
    case .transportation:
      return "🚘"
    case .services:
      return "🌐"
    case .uncleared:
      return "👀"
    }
  }
}
