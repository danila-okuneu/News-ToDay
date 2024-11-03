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
    
    let apiKey = "fab4adf6e44443e492c247e2dd606cd9"
//	66ebfdb00e474e718dc3a70bd709a6a6
//	d507c162e0a84f1ba2ca94ad479f4473
// 	52e11f09cba549a1a0817c88044c2783
//	b1b8d7d4598c477aaeeab9946c28120e
//	3868bda889de4df7aa38f2de477b1cfc
//	30804caa0fa442909fd0a2999f25c04c
//	57420ecd8c544522a97e09f00b8f979d
//	fab4adf6e44443e492c247e2dd606cd9

	func fetchRandom(categories: [Category], completion: @escaping ([NewsModel]) -> Void) {
        var newsArticles: [NewsModel] = []
        let fetchGroup = DispatchGroup()
        
        categories.forEach { topic in
            fetchGroup.enter()

			let category = topic.rawValue
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
						if let newsArray = self.parseJSON(safeData, category: topic.rawValue)  {
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
            completion(newsArticles.shuffled())
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
        performRequest(with: urlString, category: "", requestType: isCategory)
        
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

extension NewsManager {
    
    // получить дату за сегодня
    func getToday() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = formatter.string(from: date)
        return today
    }
    
    //получить дату за ВЧЕРА
    var date: String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: yesterday)
    }
}

extension NewsManager {
    
    func getRandomNews(for categories: [String], completion: @escaping ([NewsModel]) -> Void) {
        var results: [NewsModel] = []
        
        let dispatchGroup = DispatchGroup()
        
        for category in categories {
            dispatchGroup.enter()
            
            let urlString = "https://newsapi.org/v2/everything?q=\(category)&apiKey=\(apiKey)"
            guard let url = URL(string: urlString) else {
                dispatchGroup.leave()
                continue
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                defer { dispatchGroup.leave() }
                
                if let error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                
                if let data {
                    if let newsArray = parseJSON(data, category: category) {
                        results.append(newsArray.randomElement()!)
                    }
                }
            }
            .resume()
        }
        dispatchGroup.notify(queue: .main) {
            completion(results)
        }
    }
}
