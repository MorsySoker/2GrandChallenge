//
//  FilterdNewsService.swift
//  Grand
//
//  Created by MorsyElsokary on 21/07/2022.
//

import Foundation

final class FilterdNewsService {
    
    // MARK: - Properties
    
    private var networkServices: NetworkServiceProtocol
    
    // MARK: - init
    
    init(networkServices: NetworkServiceProtocol = NetworkService()) {
        self.networkServices = networkServices
    }
    
    func getArticlesWith(
        keyword: String = "bitcoin",
        page: String = "1",
        lang: String = "en",
        completion: @escaping (Result<ArticleStatus, NetworkError>) -> Void){
        let endPoint =
        FilterdNewsEndPoint.getArticlesWith(
            keyword: keyword, page: page , lang: lang)
        let request = endPoint.createRequest()
        networkServices.request(request, completion: completion)
    }
}
