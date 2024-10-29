//
//  NewsManager.swift
//  NewsToDay
//
//  Created by Anna Melekhina on 22.10.2024.
//

import Foundation
import UIKit

protocol NewsManagerDelegate {
    func didUpdateNews(manager: NewsManager, news: [NewsModel], requestType: Bool?)
    func didFailWithError(error: Error)
}

struct NewsManager {
    
    var delegate: NewsManagerDelegate?
    
    let apiKey = "57420ecd8c544522a97e09f00b8f979d"
//    30804caa0fa442909fd0a2999f25c04c
    
    func fetchRandom(categories: [String], completion: @escaping ([NewsModel]) -> Void) {
        var newsArticles: [NewsModel] = []
        let fetchGroup = DispatchGroup()
        
        categories.forEach { topic in
            fetchGroup.enter()

            let category = topic
            let urlString = "https://newsapi.org/v2/top-headlines?category=\(category)&apiKey=\(apiKey)"
            
            if let url = URL(string: urlString) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    defer { fetchGroup.leave() }
                    if error != nil {
                        print(error!.localizedDescription)
                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    
                    if let safeData = data {
                        if let newsArray = self.parseJSON(safeData, category: topic)  {
                            newsArticles.append(contentsOf: newsArray)
                            
                        } else {
                            print("failed to parse data \(category)")
                        }
                    } else {
                        print("failed to fetch Data \(category) ")
                    }
                }
                
                task.resume()
            } else {
                fetchGroup.leave()
            }
        }
        fetchGroup.notify(queue: .main) {
                completion(newsArticles.shuffled()
                )
            }
    }
            
   
    func fetchNews(topic: String, isCategory: Bool? = nil) {
        let urlString = "https://newsapi.org/v2/top-headlines?category=\(topic)&apiKey=\(apiKey)"
        print(urlString)
        print("json \(topic)")
        performRequest(with: urlString, category: topic, requestType: isCategory)
        
    }
    
    func fetchByKeyWord(keyWord: String, isCategory: Bool? = nil) {
        let urlString = "https://newsapi.org/v2/everything?q=\(keyWord)&apiKey=\(apiKey)"
        print(urlString)
        print("json \(keyWord)")
        performRequest(with: urlString, category: "General", requestType: isCategory)
        
    }
       
    func performRequest(with urlString: String, category: String, requestType: Bool? = nil ) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let newsArray = self.parseJSON(safeData, category: category) {
                        self.delegate?.didUpdateNews(manager: self, news: newsArray, requestType: requestType)
                    } else {
                        print("failed to parse data")
                    }
                } else {
                    print("failed to fetch Data")
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ newsData: Data, category: String) -> [NewsModel]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(NewsData.self, from: newsData)
            
            var newsArray: [NewsModel] = []
            for article in decodedData.articles {
                
                if article.url == "https://removed.com" {
                    print("Skipped removed content.")
                    continue
                }
                
                let author = article.author ?? ""
                let title = article.title ?? ""
                let content = article.content ?? "Read the full article on the site of the publisher"
                let urlToImage = article.urlToImage ?? ""
                let publishedAt = article.publishedAt ?? ""
                let urlArticle = article.url
                let description = article.description?.description ?? ""
                
                let news = NewsModel(
                    author: author,
                    title: title,
                    content: content,
                    urlToImage: urlToImage,
                    publishedAt: publishedAt,
                    urlArticle: urlArticle,
                    category: category,
                    description: description
                )
                newsArray.append(news)
            }
            
            return newsArray
            
            } catch {
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
    
}

