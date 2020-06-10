//
//  Covid19Class.swift
//  Covid19
//
//  Created by Saud Almutlaq on 11/05/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let covidSA = try? newJSONDecoder().decode(CovidSA.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.covidSAElementTask(with: url) { covidSAElement, response, error in
//     if let covidSAElement = covidSAElement {
//       ...
//     }
//   }
//   task.resume()

import Foundation

var allData:CovidSA! = CovidSA.init()

// MARK: - CovidSAElement
class CovidSAElement: Codable {
    let country, countryCode, province, city: String
    let cityCode, lat, lon: String
    let confirmed, deaths, recovered, active: Int
    let date: Date

    enum CodingKeys: String, CodingKey {
         case country = "Country"
         case countryCode = "CountryCode"
         case province = "Province"
         case city = "City"
         case cityCode = "CityCode"
         case lat = "Lat"
         case lon = "Lon"
         case confirmed = "Confirmed"
         case deaths = "Deaths"
         case recovered = "Recovered"
         case active = "Active"
         case date = "Date"
     }

    init(country: String, countryCode: String, province: String, city: String, cityCode: String, lat: String, lon: String, confirmed: Int, deaths: Int, recovered: Int, active: Int, date: Date) {
        self.country = country
        self.countryCode = countryCode
        self.province = province
        self.city = city
        self.cityCode = cityCode
        self.lat = lat
        self.lon = lon
        self.confirmed = confirmed
        self.deaths = deaths
        self.recovered = recovered
        self.active = active
        self.date = date
    }
}

typealias CovidSA = [CovidSAElement]

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func covidSATask(with url: URL, completionHandler: @escaping (CovidSA?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
