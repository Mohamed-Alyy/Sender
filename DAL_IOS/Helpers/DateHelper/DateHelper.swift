//
//  DateHelper.swift
//  SupportI
//
//  Created by Mohamed Abdu on 2/5/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation

class DateHelper {
    /** Wednesday, May 30, 2018
     EEEE, MMM d, yyyy
     05/30/2018
     MM/dd/yyyy
     05-30-2018 12:14
     MM-dd-yyyy HH:mm
     May 30, 12:14 PM
     MMM d, h:mm a
     May 2018
     MMMM yyyy
     May 30, 2018
     MMM d, yyyy
     Wed, 30 May 2018 12:14:27 +0000
     E, d MMM yyyy HH:mm:ss Z
     2018-05-30T12:14:27+0000
     yyyy-MM-dd'T'HH:mm:ssZ
     30.05.18
     dd.MM.yy
     **/
    enum DateType: String {
        case hourly = "hh"
        case hourly24 = "HH"
        case hourlyM = "hh:mm"
        case hourly24M = "HH:mm"
        case year = "yyyy"
        case full = "yyyy-MM-dd HH:mm:ss"
        case monthString = "MMM"
        case month = "MM"
        case day = "dd"
    }
    enum DateLocale: String {
        case english = "en_US_POSIX"
        case arabic = "ar_EG"
    }
    static var currentLocal: DateLocale?
    static var locale: String {
        get {
            if currentLocal != nil {
                return currentLocal?.rawValue ?? DateLocale.english.rawValue
            } else {
                if getAppLang().rawValue == "ar" {
                    return DateLocale.arabic.rawValue
                } else {
                    return DateLocale.english.rawValue
                }
            }
        }
    }
    func currentFullFormat() -> String? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateOrginial = dateFormatter.string(from: date)
        return dateOrginial
    }
    func currentDateFullFormat() -> Date? {
        guard let date = Date.current() else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateOrginial = dateFormatter.date(from: date)
        return dateOrginial
    }
    func currentDate() -> String? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateOrginial = dateFormatter.string(from: date)
        return dateOrginial
    }
    /// start with date yyyy-mm-dd hh:mm:ii
    ///
    /// - Parameter original: string date
    /// - Returns: return Date Object
    func originalDate(original: String, oldFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = oldFormat
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let dateOrginial = dateFormatter.date(from: original)
        return dateOrginial
    }
    func locale() -> String {
//        if getAppLang() == "ar" {
//            DateHelper.locale = DateLocale.arabic.rawValue
//        } else {
//            DateHelper.locale = DateLocale.english.rawValue
//        }
        return DateHelper.locale
    }
    func date(date: String?, format: String, oldFormat: String = "yyyy-MM-dd HH:mm:ss") -> String? {
        guard let dateUse = date else {return nil}
        let dateD = originalDate(original: dateUse, oldFormat: oldFormat)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: locale()) // set locale to reliable US_POSIX
        if dateD != nil {
            let dateString = dateFormatter.string(from: dateD!)
            return dateString
        } else {
            return nil
        }
    }
    func dateType(date: String?, format: String, oldFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        guard let dateUse = date else {return nil}
        let dateD = self.date(date: dateUse, format: format, oldFormat: oldFormat)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: locale()) // set locale to reliable US_POSIX
        if dateD != nil {
            let dateString = dateFormatter.date(from: dateD!)
            return dateString
        } else {
            return nil
        }
    }
    func date(date: Date?, format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: locale()) // set locale to reliable US_POSIX
        if date != nil {
            let dateString = dateFormatter.string(from: date!)
            return dateString
        } else {
            return nil
        }
    }
    func convertToHoursMinutesSeconds (seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    func convertToHoursMinutesSeconds (firstTimeStamp: Int, secondTimeStamp: Int) -> (Int, Int, Int) {
        let seconds = firstTimeStamp - secondTimeStamp
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    func secondsForHours(firstDate: String?, oldFormat: String = "yyyy-MM-dd HH:mm:ss") -> Int? {
        let dateHour = date(date: firstDate, format: "HH:mm", oldFormat: oldFormat)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: dateHour ?? "")
        if let date = date {
            return Date().timeIntervalSince(date).int
        }
        return nil
    }
    func secondsForDate(firstDate: String?, oldFormat: String = "yyyy-MM-dd HH:mm:ss") -> Int? {
        let dateHour = date(date: firstDate, format: oldFormat, oldFormat: oldFormat)
        let formatter = DateFormatter()
        formatter.dateFormat = oldFormat
        let date = formatter.date(from: dateHour ?? "")
        if let date = date {
            return Date().timeIntervalSince(date).int
        }
        return nil
    }
    func secondsForDate(firstDate: Date?) -> Int? {
        if let date = firstDate {
            return Date().timeIntervalSince(date).int
        }
        return nil
    }
    func compare(firstDate: String?, secondDate: String?, oldFormat: String = "yyyy-MM-dd HH:mm:ss") -> Bool? {
        let firstDateType = originalDate(original: firstDate ?? "", oldFormat: oldFormat)
        let secondDateType = originalDate(original: secondDate ?? "", oldFormat: oldFormat)
        if let date1 = firstDateType, let date2 = secondDateType {
            if date1 < date2 {
                return true
            } else {
                return false
            }
        }
        return nil
    }
    func checkTimeAfterNight(firstDate: String?, oldFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        DateHelper.currentLocal = .english
        let dateHour = date(date: firstDate, format: "HH", oldFormat: oldFormat)
        if dateHour?.int ?? 0 < 12 {
            let date = originalDate(original: firstDate ?? "", oldFormat: "yyyy-MM-dd HH:mm:ss")?.addingTimeInterval(60*60*24)
            return date
        } else {
            let date = originalDate(original: firstDate ?? "", oldFormat: oldFormat)
            return date
        }
    }
}

extension Date {
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
}
