//
//  Date+Alfheim.swift
//  Alfheim
//
//  Created by alex.huo on 2020/2/28.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension Date {
  var startOfWeek: Date {
    return start(of: .week)
  }

  var startOfMonth: Date {
    return start(of: .month)
  }

  var startOfYear: Date {
    return start(of: .year)
  }
}

extension Date {
  enum StartComponent {
    case week
    case month
    case year
  }

  func start(of start: StartComponent, calendar: Calendar = Calendar.current) -> Date {
    let components: Set<Calendar.Component>
    switch start {
    case .week:
      components = [.yearForWeekOfYear, .weekOfYear]
    case .month:
      components = [.year, .month]
    case .year:
      components = [.year]
    }
    let dateComponents = calendar.dateComponents(components, from: self)
    return calendar.date(from: dateComponents)!
  }

  func next(of component: StartComponent, calendar: Calendar = .current) -> Date {
    switch component {
    case .week:
      return calendar.date(byAdding: .day, value: 7, to: self)!
    case .month:
      return calendar.date(byAdding: .month, value: 1, to: self)!
    case .year:
      return calendar.date(byAdding: .year, value: 1, to: self)!
    }
  }

  func end(of component: StartComponent, calendar: Calendar = .current) -> Date {
    switch component {
    case .week:
      return next(of: .week, calendar: calendar).start(of: .week)
    case .month:
      return next(of: .month, calendar: calendar).start(of: .month)
    case .year:
      return next(of: .year, calendar: calendar).start(of: .year)
    }
  }
}

extension Date {
  var string: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy 'at' HH:mm"
    return formatter.string(from: self)
  }
}
