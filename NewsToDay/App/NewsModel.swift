//
//  NewsModel.swift
//  NewsToDay
//
//  Created by Anna Melekhina on 22.10.2024.
//

import Foundation

struct NewsModel: Codable, Hashable, Equatable {
    let author: String
    let title: String
    let content: String
    let urlToImage: String?
    let publishedAt: String
    let urlArticle: String
    let category: String
    let description: String
}
