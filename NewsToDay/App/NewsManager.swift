//
//  NewsManager.swift
//  NewsToDay
//
//  Created by Anna Melekhina on 22.10.2024.
//

import Foundation

protocol NewsManagerDelegate {
    func didUpdateNews(manager: NewsManager, news: NewsModel)
    func didFailWithError(error: Error)
}
struct NewsManager {
    
        var delegate: NewsManagerDelegate?
    
    let apiKey = "30804caa0fa442909fd0a2999f25c04c"
    
        //дата за ВЧЕРА
    var date: String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
              let formatter = DateFormatter()
              formatter.dateFormat = "yyyy-MM-dd"
              return formatter.string(from: yesterday)
    }
//    var topic: String {
//        topics.randomElement() ?? "General"
//     }
    
    // URL для джейсона
//    var baseURL: String {
//        return "https://newsapi.org/v2/top-headlines?category=\(topic)&apiKey=\(apiKey)"
//        }
    
    
//    let topics = ["business","entertainment","general","health","science","sports","technology"]

        // метод за сегодня
    func getToday() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = formatter.string(from: date)
        return today
    }
    
    func fetchNews(topic: String) {
        let urlString = "https://newsapi.org/v2/top-headlines?category=\(topic)&apiKey=\(apiKey)"
        print(urlString)
        print("json \(topic)")
        performRequest(with: urlString)
        
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let news = self.parseJSON(safeData) {
                        self.delegate?.didUpdateNews(manager: self, news: news)
                        
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
    
    func parseJSON(_ newsData: Data) -> NewsModel? {
                   let decoder = JSONDecoder()
                   
                   do {
                       let decodedData = try decoder.decode(NewsData.self, from: newsData)
                       let article = decodedData.articles.randomElement()!
                       let author = article.author ?? "_"
                       let title = article.title ?? "_"
                       let content = article.content ?? "_"
                       
                       
                       let news = NewsModel(author: author, title: title, content: content)
                       return news
                       
                   } catch {
                       delegate?.didFailWithError(error: error)
                       print(error)
                       return nil
                   }
               }

    
    
}
    
