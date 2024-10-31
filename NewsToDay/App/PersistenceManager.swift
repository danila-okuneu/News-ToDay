import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let bookmarks = "bookmarks"
    }
    
    static func updateWith(bookmark: NewsModel, actionType: PersistenceActionType, completed: @escaping(ErrorMessage?) -> Void) {
        retrieveBookmarks { result in
            switch result {
            case .success(var bookmarks):
                
                switch actionType {
                case .add:
                    guard !bookmarks.contains(bookmark) else {
                        completed(.alreadyInBookmarks)
                        return
                    }
                    bookmarks.append(bookmark)
                case .remove:
                    bookmarks.removeAll { $0.title == bookmark.title }
                }
                
                completed(save(bookmarks: bookmarks))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveBookmarks(completed: @escaping(Result<[NewsModel], ErrorMessage>) -> Void) {
        guard let bookmarksData = defaults.object(forKey: Keys.bookmarks) as? Data else {
            //if we dont have bookmarks, just return empty array
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let bookmarks = try decoder.decode([NewsModel].self, from: bookmarksData)
            completed(.success(bookmarks))
        } catch {
            completed(.failure(.unableToBookmark))
        }
    }
    
    static func save(bookmarks: [NewsModel]) -> ErrorMessage? {
        do {
            let encoder = JSONEncoder()
            let encodedBookmarks = try encoder.encode(bookmarks)
            defaults.setValue(encodedBookmarks, forKey: Keys.bookmarks)
            return nil
        } catch {
            return .unableToBookmark
        }
    }
    
    static func isBookmarked(_ bookmark: NewsModel, completion: @escaping (Bool) -> Void) {
        retrieveBookmarks { result in
            switch result {
            case .success(let bookmarks):
                let isBookmarked = bookmarks.contains { $0.title == bookmark.title }
                completion(isBookmarked)
            case .failure:
                completion(false)
            }
        }
    }
}
