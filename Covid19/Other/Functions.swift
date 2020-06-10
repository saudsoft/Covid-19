//
//  Functions.swift
//  Covid19
//
//  Created by Saud Almutlaq on 12/05/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import Foundation
import iProgressHUD

var numLang:String!
var dateType:String!
var dateLanguage:String!


func dateToString(currentDate:Date, outputFormat:String) -> String {
    let formatter = DateFormatter()
    // initially set the format based on your datepicker date / server String
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let myString = formatter.string(from: currentDate) // string purpose I add here
    // convert your string to date
    let yourDate = formatter.date(from: myString)
    //then again set the date format whhich type of output you need
    // "yyyy-MM-dd HH:mm:ss"
    formatter.dateFormat = outputFormat
    // again convert your date to string
    
    return formatter.string(from: yourDate!)
}

func hijriDate(gregDate: Date) -> String {
    let dateFor = DateFormatter()
    
    let hijriCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
    dateFor.locale = Locale.init(identifier: "ar") // or "en" as you want to show numbers
    
    dateFor.calendar = hijriCalendar
    
    dateFor.dateFormat = "EEEE yyyy/MM/dd"
    return dateFor.string(from: gregDate)
}

func formatNumber(number:Int, lang:String = "EN") -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0;
    formatter.locale = Locale(identifier: lang)
    return formatter.string(from: NSNumber(value: number))!
}

var countriesTodayStatistics:StatisticsByCountry = StatisticsByCountry()

func loadCountriesTodayStatistics() {
    let url = URL(string: "https://corona.lmao.ninja/v2/countries?today=true")!
    
       let task = URLSession.shared.statisticsByCountryTask(with: url) { statisticsByCountry, response, error in
         if let statisticsByCountry = statisticsByCountry {
            countriesTodayStatistics = statisticsByCountry
//            print(countriesTodayStatistics.count)
         }
       }
       task.resume()
    
}
func showProgress(_ sender: UIView, indecatorType:NVActivityIndicatorType = .ballRotateChase) {
    let iprogress: iProgressHUD = iProgressHUD()
    iprogress.isShowModal = false
    iprogress.isShowCaption = true
    iprogress.attachProgress(toView: sender)

    // Change caption on the fly directly from the view
    sender.updateCaption(text: "تحميل!")
    // Change indicator type on the fly directly from the view
    sender.updateIndicator(style: indecatorType)
    // Show iProgressHUD directly from view
    sender.showProgress()
}

func hideProgress(_ sender: UIView) {
    sender.dismissProgress()
}

func getArabicCountriesName(from countryCode:String) -> (String, String) {

    var arabicName: String = ""
    var englishName: String = ""
    
    for code in NSLocale.isoCountryCodes as [String] {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        if code == countryCode {
            let nameAR = NSLocale(localeIdentifier: "ar_SA").displayName(forKey: NSLocale.Key.identifier, value: id) ?? ""
            let nameEN = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? ""

//            print("Arabic \(nameAR), English: \(nameEN), Code: \(code), CountryCode: \(countryCode)")
            arabicName = nameAR
            englishName = nameEN
        }
    }
    
    return (englishName, arabicName)
}

/// Convert the time from Int timestamp to formated string
///
///   Return Formats Examples:
///   - Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
///   - 09/12/2018                        --> MM/dd/yyyy
///   - 09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
///   - Sep 12, 2:11 PM                   --> MMM d, h:mm a
///   - September 2018                    --> MMMM yyyy
///   - Sep 12, 2018                      --> MMM d, yyyy
///   - Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
///   - 2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
///   - 12.09.18                          --> dd.MM.yy
///   - 10:41:02.112                      --> HH:mm:ss.SSS
///   - 10:41 PM                          --> hh:mm a
///
/// - Parameters:
///    - timestamp: a timestamp to be converted to formated time.
///    - format: the output format needed, "one of the examples above"
///
/// - Returns:
///   String: formated time.
func getFormatedDateTime(byTimestamp timestamp: Double, type:String = "en_SA") -> String {
    
    let date = NSDate(timeIntervalSince1970: TimeInterval(timestamp))
    
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.locale = NSLocale(localeIdentifier: type) as Locale

    dayTimePeriodFormatter.dateFormat = "EEEE, d MMM yyyy - hh:mm a"
    
    return dayTimePeriodFormatter.string(from: date as Date)
}
