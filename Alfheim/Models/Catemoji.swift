//
//  Catemoji.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/1.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

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
}


extension Catemoji {
  enum Food: String {
    case groceries = "🛒"
    case eating = "🍽"
    case snacks = "🍟"
    case others = "🍔"
  }

  enum Fruit: String {
    case apple = "🍎"
    case banana = "🍌"
    case grapes = "🍇"
    case cherries = "🍒"
    case others = "🍓"
  }

  enum Drink: String {
    case beer = "🍻"
    case milk = "🥛"
    case tea = "🥤"
    case wine = "🍷"
    case others = "🍹"
  }

  enum Clothes: String {
    case thirt = "👕"
    case pants = "👖"
    case sock = "🧦"
    case coat = "🧥"
    case skirt = "👗"
    case others = "👔"
  }

  enum Household: String {
    case goods = "🧺"
    case travel = "🏖"
    case others = "🏠"
  }

  enum Personal: String {
    case health = "💊"
    case privacy = "🔏"
    case others = "🤷‍♂️"
  }

  enum Transportation: String {
    case taxi = "🚕"
    case car = "🚘"
    case airplane = "✈️"
    case bus = "🚙"
    case metro = "🚇"
    case train = "🚄"
    case boat = "🛳"
    case others = "🚲"
  }
}
