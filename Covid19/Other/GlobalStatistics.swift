//
//  GlobalStatistics.swift
//  Covid19
//
//  Created by Saud Almutlaq on 09/06/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import Foundation

typealias GlobalStatistics = [String: Double]

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

    func globalStatisticsTask(with url: URL, completionHandler: @escaping (GlobalStatistics?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
