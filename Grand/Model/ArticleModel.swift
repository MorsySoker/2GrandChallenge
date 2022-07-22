//
//  ArticleModel.swift
//  Grand
//
//  Created by MorsyElsokary on 21/07/2022.
//

import Foundation

// MARK: - Article Api response Status

struct ArticleStatus: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article

struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source

struct Source: Codable {
    let id: String?
    let name: String?
}

extension ArticleStatus {
    
    func toHeadLineCellViewModel(indexPath: Int) -> HeadLineCellViewModel? {
        guard let articles = articles else {
            return nil
        }
        
        let headLineCellViewModel = HeadLineCellViewModel(
            imageURL: articles[indexPath].urlToImage ?? "",
            title: articles[indexPath].title ?? "UnKnown",
            auther: articles[indexPath].author ?? "Unknown",
            articleURL: articles[indexPath].url ?? "")
        
        return headLineCellViewModel
    }
}
