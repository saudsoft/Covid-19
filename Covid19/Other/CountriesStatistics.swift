//
//  SaudiStatistics.swift
//  Covid19
//
//  Created by Saud Almutlaq on 09/06/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let statisticsByCountry = try? newJSONDecoder().decode(StatisticsByCountry.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.statisticsByCountryElementTask(with: url) { statisticsByCountryElement, response, error in
//     if let statisticsByCountryElement = statisticsByCountryElement {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - StatisticsByCountryElement
class StatisticsByCountryElement: Codable {
    let updated: Int?
    let country: String?
    let countryInfo: CountryInfo?
    let cases, todayCases, deaths, todayDeaths: Int?
    let recovered, todayRecovered, active, critical: Int?
    let casesPerOneMillion, deathsPerOneMillion: Double?
    let tests, testsPerOneMillion, population: Int?
    let continent: Continent?
    let oneCasePerPeople, oneDeathPerPeople, oneTestPerPeople: Int?
    let activePerOneMillion, recoveredPerOneMillion, criticalPerOneMillion: Double?
    
    init(updated: Int?, country: String?, countryInfo: CountryInfo?, cases: Int?, todayCases: Int?, deaths: Int?, todayDeaths: Int?, recovered: Int?, todayRecovered: Int?, active: Int?, critical: Int?, casesPerOneMillion: Double?, deathsPerOneMillion: Double?, tests: Int?, testsPerOneMillion: Int?, population: Int?, continent: Continent?, oneCasePerPeople: Int?, oneDeathPerPeople: Int?, oneTestPerPeople: Int?, activePerOneMillion: Double?, recoveredPerOneMillion: Double?, criticalPerOneMillion: Double?) {
        self.updated = updated
        self.country = country
        self.countryInfo = countryInfo
        self.cases = cases
        self.todayCases = todayCases
        self.deaths = deaths
        self.todayDeaths = todayDeaths
        self.recovered = recovered
        self.todayRecovered = todayRecovered
        self.active = active
        self.critical = critical
        self.casesPerOneMillion = casesPerOneMillion
        self.deathsPerOneMillion = deathsPerOneMillion
        self.tests = tests
        self.testsPerOneMillion = testsPerOneMillion
        self.population = population
        self.continent = continent
        self.oneCasePerPeople = oneCasePerPeople
        self.oneDeathPerPeople = oneDeathPerPeople
        self.oneTestPerPeople = oneTestPerPeople
        self.activePerOneMillion = activePerOneMillion
        self.recoveredPerOneMillion = recoveredPerOneMillion
        self.criticalPerOneMillion = criticalPerOneMillion
    }
}

enum Continent: String, Codable {
    case africa = "Africa"
    case asia = "Asia"
    case australiaOceania = "Australia/Oceania"
    case empty = ""
    case europe = "Europe"
    case northAmerica = "North America"
    case southAmerica = "South America"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.countryInfoTask(with: url) { countryInfo, response, error in
//     if let countryInfo = countryInfo {
//       ...
//     }
//   }
//   task.resume()

// MARK: - CountryInfo
class CountryInfo: Codable {
    let id: Int?
    let iso2, iso3: String?
    let lat, long: Double?
    let flag: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case iso2, iso3, lat, long, flag
    }

    init(id: Int?, iso2: String?, iso3: String?, lat: Double?, long: Double?, flag: String?) {
        self.id = id
        self.iso2 = iso2
        self.iso3 = iso3
        self.lat = lat
        self.long = long
        self.flag = flag
    }
}

typealias StatisticsByCountry = [StatisticsByCountryElement]

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

    func statisticsByCountryTask(with url: URL, completionHandler: @escaping (StatisticsByCountry?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
