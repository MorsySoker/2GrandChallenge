//
//  HeadlinesEndPoint.swift
//  Grand
//
//  Created by MorsyElsokary on 22/07/2022.
//

import Foundation

enum HeadlinesEndPoint {
    
    case getHeadLines(page: String, country: String, category: String?)
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getHeadLines: return .GET
        }
    }
    
    var requestBody: Encodable? {
        switch self {
        default:
            return nil
        }
    }
    
    func getURL() -> String {
        switch self {
        case .getHeadLines(let page, let country, let category):
            return "https://newsapi.org/v2/top-headlines?apiKey=\(Enviroment.newsApiKey)&country=\(country)&page=\(page)&pageSize=10&category=\(category ?? "")"
        }
    }
    
    func createRequest(token: String? = nil) -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        return NetworkRequest(url: getURL(),
                              headers: headers,
                              requestBody: requestBody,
                              httpMethod: httpMethod)
    }
    
}
