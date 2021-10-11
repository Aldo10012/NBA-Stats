//
//  Date.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import Foundation


let yesterday = getDateAsString(.yesterday)
let today = getDateAsString(.today)
let tomorrow = getDateAsString(.tomorrow)

enum DateType{
  case yesterday
  case today
  case tomorrow
}

func getDateAsString(_ dateType: DateType) -> String {
    var date = Date()

    switch dateType {
    case .yesterday: date = date.yesterday
    case .today:     date = date.today
    case .tomorrow:  date = date.tomorrow
    }

  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "YYYY-MMM-dd"
  let dateAsString = dateFormatter.string(from: date)

  return dateAsString

}

extension Date {
    ///https://stackoverflow.com/questions/44009804/swift-3-how-to-get-date-for-tomorrow-and-yesterday-take-care-special-case-ne/44009988

    var yesterday: Date { return Date().dayBefore }
    var today:     Date { return Date() }
    var tomorrow:  Date { return Date().dayAfter }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
