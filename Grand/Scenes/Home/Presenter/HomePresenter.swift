//
//  HomePresenter.swift
//  Grand
//
//  Created by MorsyElsokary on 21/07/2022.
//

import Foundation

protocol HomePresenterViewDelegate: AnyObject {
    
    func reloadTableView()
    func startActivityIndicator()
    func stopActivityIndicator()
}

final class HomePresenter {
    
    // MARK: - Properties
    
    private var filterdArticles: [Article]?
    private let networkService: FilterdNewsService
    weak var viewDelegate: HomePresenterViewDelegate!
    var currentPage: Int = 1
    var numberOfPages: Double?
    var searchKeyword: String = "bitcoin"
    
    // MARK: - init
    
    init(networkService: FilterdNewsService) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    
    func getArticlesAbout(
        keyword: String = "bitcoin",
        page: String = "1") {
            
            let lang = (Lang(rawValue: UserUtilites.loadLang() ?? "english") ?? .english).urlLang()
            
            viewDelegate.startActivityIndicator()
            
            networkService.getArticlesWith(
                keyword: keyword,
                page: page,
                lang: lang)
            { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let articles):
                    self.filterdArticles = articles.articles
                    self.viewDelegate.reloadTableView()
                    if let totalResults = articles.totalResults {
                        self.numberOfPages = (Double(totalResults)/10).rounded(.up)
                    }
                    self.viewDelegate.stopActivityIndicator()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self.viewDelegate.stopActivityIndicator()
                }
            }
        }
    
    func getArticlesCount() -> Int {
        
        guard let filterdArticles = filterdArticles else {
            return 0
        }
        return filterdArticles.count
    }
    
    func getArticle(at indexpath: Int) -> Article? {
        guard let filterdArticles = filterdArticles else {
            return nil
        }
        return filterdArticles[indexpath]
    }
}
