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
}

extension Date {
  enum EndComponent {
    case day
    case week
    case month
    case year
  }
}

extension Date {
  var string: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy 'at' HH:mm"
    return formatter.string(from: self)
  }
}
