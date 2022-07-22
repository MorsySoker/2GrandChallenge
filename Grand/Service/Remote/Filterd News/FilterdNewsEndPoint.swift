//
//  FilterdNewsEndPoint.swift
//  Grand
//
//  Created by MorsyElsokary on 21/07/2022.
//

import Foundation

enum FilterdNewsEndPoint {
    
    case getArticlesWith(keyword: String, page: String, lang: String)
    
    var requestTimeOut: Int {
        20
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getArticlesWith: return .GET
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
        case .getArticlesWith(let keyword, let page, let lang):
            return "\(Enviroment.baseURL)everything?q=\(keyword)&apiKey=\(Enviroment.newsApiKey)&page=\(page)&language=\(lang)"
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
