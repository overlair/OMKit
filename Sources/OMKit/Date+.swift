//
//  File.swift
//  
//
//  Created by John Knowles on 7/28/24.
//

import Foundation

public extension Date {
    public static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    public static func timeStringSince(fromConverted date: Date) -> String {
        let diffDates = NSCalendar.current.dateComponents([.day, .hour, .minute, .second], from: date, to: Date())
        
        if let year = diffDates.year, year > 0 {
            let isPlural = year != 1
            return "\(year ) year\(isPlural ? "s" : "")"
        } else if let month = diffDates.month, month > 0 {
            let isPlural = month != 1
                return "\(month) month\(isPlural ? "s" : "")"
        } else if let week = diffDates.day, week > 7 {
            let isPlural = week != 1
            return "\(week / 7) week\(isPlural ? "s" : "")"
        } else if let day = diffDates.day, day > 0 {
            let isPlural = day != 1
            return "\(day) day\(isPlural ? "s" : "")"
        } else if let hour = diffDates.hour, hour > 0 {
            let isPlural = hour != 1
            return "\(hour) hour\(isPlural ? "s" : "")"
        } else if let minute = diffDates.minute, minute > 0 {
            let isPlural = minute != 1
            return "\(minute) min\(isPlural ? "s" : "")"
        } else if let second = diffDates.second, second > 0 {
            let isPlural = second != 1
            return "\(second) sec\(isPlural ? "s" : "")"
        } else {
            return "1 sec"
        }
    }
}

@available(macOS 12, *)
@available(iOS 15.0, *)
extension Date {
    
    enum Section {
        case day
        case week
        case month
        case year
    }
    
    var calendar: Calendar {
        Calendar.current
    }
    
    
    func start(of section: Section) ->  Date {
        switch section {
        case .day: return self.beginningOfDay()
        case .week: return self.beginningOfWeek()
        case .month: return self.beginningOfMonth()
        case .year: return self.beginningOfYear()
        }
    }
    
    func end(of section: Section) ->  Date {
        switch section {
        case .day: return self.endOfDay()
        case .week: return self.endOfWeek()
        case .month: return self.endOfMonth()
        case .year: return self.endOfYear()
        }
    }
    
    func beginningOfDay() -> Date {
        calendar.startOfDay(for: self)
    }
    
    func endOfDay() -> Date {
        calendar.date(byAdding: .day, value: 1, to: self.beginningOfDay()) ?? self
    }
    
    
    
    func beginningOfMonth() -> Date {
        calendar.date(from: calendar.dateComponents([.year, .month],
                                                    from: calendar.startOfDay(for: self))) ?? self
    }
    
    func endOfMonth() -> Date {
        return calendar.date(byAdding: DateComponents(month: 1, day: -1),
                             to: self.beginningOfMonth())  ?? self
        
    }
    
    func beginningOfYear() -> Date {
        calendar.date(from: calendar.dateComponents([.year],
                                                    from: calendar.startOfDay(for: self))) ?? self
    }
    
    func endOfYear() -> Date {
        return calendar.date(byAdding: DateComponents(year: 1, day: -1),
                             to: self.beginningOfYear())  ?? self
        
    }
    
    func beginningOfWeek() -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date ?? self
    }
    
    func endOfWeek() -> Date {
        return calendar.date(byAdding: DateComponents(day: 7),
                             to: self.beginningOfWeek())  ?? self
        
    }
    
    
    var numeric: Double {
        self.timeIntervalSince1970
    }
    var isToday: Bool {
        calendar.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        calendar.isDateInYesterday(self)
        
    }
    
    var year: Int? {
        return Calendar.current.dateComponents([.year], from: self).year
    }
    
    
    var month: Int? {
        return Calendar.current.dateComponents([.month], from: self).month
    }
    
    var day: Int? {
        return Calendar.current.dateComponents([.day], from: self).day
    }
    
    var isPast7Days: Bool {
        guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: Date.now.beginningOfDay())   else { return false }
        return self.numeric  > sevenDaysAgo.numeric
    }
    
    
    
    var isPastMonth: Bool {
        guard let thirtyDaysAgo = calendar.date(byAdding: .month, value: -1, to: Date.now.beginningOfDay())   else { return false }
        return self.numeric  > thirtyDaysAgo.numeric
    }
    
    
    var isPastYear: Bool {
        guard let thirtyDaysAgo = calendar.date(byAdding: .year, value: -1, to: Date.now.beginningOfDay())   else { return false }
        return self.numeric  > thirtyDaysAgo.numeric
    }
    
    var  currentYear: Int {
        calendar.component(.year, from: self)
    }
    
    func dayNumberOfWeek() -> Int? {
           return Calendar.current.dateComponents([.weekday], from: self).weekday
       }
}

func daysInMonth(year: Int, month: Int) -> Int {
    let dateComponents = DateComponents(year: year, month: month)
    let calendar = Calendar.current
    
    guard let date = calendar.date(from: dateComponents),
          let range = calendar.range(of: .day, in: .month, for: date) else { return 0 }
    
    return range.count
}




@available(macOS 12, *)
@available(iOS 15.0, *)

func startingDayForMonth(year: Int, month: Int) -> Int {
    let dateComponents = DateComponents(year: year, month: month, day: 1)
    let calendar = Calendar.current
    
    guard let date = calendar.date(from: dateComponents) else { return 0 }
    
    let day = date.dayNumberOfWeek() ?? 0
    switch day {
    case 7: return 0
    default: return day
    }
}


extension Date {
    @available(macOS 12, *)
    @available(iOS 15.0, *)
    static func random() -> Self {
        // 3ish years
        let interval = TimeInterval.random(in: -1_000_000_000...1_000_000_000)
        let date = Date.now.addingTimeInterval(interval)
        return date
    }
}
