//
//  HeadLinesService.swift
//  Grand
//
//  Created by MorsyElsokary on 22/07/2022.
//

import Foundation

final class HeadLinesService {
    
    // MARK: - Properties
    
    private var networkServices: NetworkServiceProtocol
    
    // MARK: - init
    
    init(networkServices: NetworkServiceProtocol = NetworkService()) {
        self.networkServices = networkServices
    }
    
    func getHeadlines(
        page: String = "1",
        country: String = "us",
        category: String = "",
        completion: @escaping (Result<ArticleStatus, NetworkError>) -> Void){
            let endPoint =
            HeadlinesEndPoint.getHeadLines(
                page: page,
                country: country,
                category: category)
            let request = endPoint.createRequest()
            networkServices.request(request, completion: completion)
        }
}
