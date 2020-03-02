//
//  Catemoji.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/1.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension Alne {
  /// Category emoji
  enum Catemoji {
    case food(Food)
    case fruit(Fruit)
    case drink(Drink)
    case clothes(Clothes)
    case household(Household)
    case transportation(Transportation)
    case personal(Personal)

    var emoji: String {
      switch self {
      case .food(let food):
        return food.rawValue
      case .fruit(let fruit):
        return fruit.rawValue
      case .drink(let drink):
        return drink.rawValue
      case .clothes(let clothes):
        return clothes.rawValue
      case .household(let household):
        return household.rawValue
      case .transportation(let transport):
        return transport.rawValue
      case .personal(let personal):
        return personal.rawValue
      }
    }

    var category: String {
      switch self {
      case .food:
        return "Food"
      case .fruit:
        return "Fruit"
      case .drink:
        return "Drink"
      case .clothes:
        return "Clothes"
      case .household:
        return "Household"
      case .transportation:
        return "Transportation"
      case .personal:
        return "Personal"
      }
    }

    var allCases: [Catemoji] {
      switch self {
      case .food:
        return Food.allCases.map { .food($0) }
      case .fruit:
        return Fruit.allCases.map { .fruit($0) }
      case .drink:
        return Drink.allCases.map { .drink($0) }
      case .clothes:
        return Clothes.allCases.map { .clothes($0) }
      case .household:
        return Household.allCases.map { .household($0) }
      case .transportation:
        return Transportation.allCases.map { .transportation($0) }
      case .personal:
        return Personal.allCases.map { .personal($0) }
      }
    }

    static var allCases: [Catemoji] {
      return [.food(.others), .fruit(.others), .drink(.others), .clothes(.others), .household(.others), .transportation(.others), .personal(.others)]
    }
  }
}


extension Alne.Catemoji {
  enum Food: String, CaseIterable {
    case groceries = "🛒"
    case eating = "🍽"
    case snacks = "🍟"
    case others = "🍔"

    var catemoji: Alne.Catemoji {
      .food(self)
    }
  }

  enum Fruit: String, CaseIterable {
    case apple = "🍎"
    case banana = "🍌"
    case grapes = "🍇"
    case cherries = "🍒"
    case others = "🍓"

    var catemoji: Alne.Catemoji {
      .fruit(self)
    }
  }

  enum Drink: String, CaseIterable {
    case beer = "🍻"
    case milk = "🥛"
    case tea = "🥤"
    case wine = "🍷"
    case others = "🍹"

    var catemoji: Alne.Catemoji {
      .drink(self)
    }
  }

  enum Clothes: String, CaseIterable {
    case thirt = "👕"
    case pants = "👖"
    case sock = "🧦"
    case coat = "🧥"
    case skirt = "👗"
    case others = "👔"

    var catemoji: Alne.Catemoji {
      .clothes(self)
    }
  }

  enum Household: String, CaseIterable {
    case goods = "🧺"
    case travel = "🏖"
    case others = "🏠"

    var catemoji: Alne.Catemoji {
      .household(self)
    }
  }

  enum Personal: String, CaseIterable {
    case health = "💊"
    case privacy = "🔏"
    case others = "🤷‍♂️"

    var catemoji: Alne.Catemoji {
      .personal(self)
    }
  }

  enum Transportation: String, CaseIterable {
    case taxi = "🚕"
    case car = "🚘"
    case airplane = "✈️"
    case bus = "🚙"
    case metro = "🚇"
    case train = "🚄"
    case boat = "🛳"
    case others = "🚲"

    var catemoji: Alne.Catemoji {
      .transportation(self)
    }
  }
}
