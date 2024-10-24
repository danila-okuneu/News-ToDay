//
//  NewsData.swift
//  NewsToDay
//
//  Created by Anna Melekhina on 22.10.2024.
//

import Foundation

struct NewsData: Decodable {
    let articles: [Articles]
}

struct Articles: Decodable {
    let author: String?
    let title: String?
    let urlToImage: String?
    let url: String
    let content: String?
    let publishedAt: String?
}
