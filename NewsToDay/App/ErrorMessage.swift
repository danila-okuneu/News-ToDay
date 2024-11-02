import Foundation

enum ErrorMessage: String, Error {
    case unableToBookmark = "There was an error while saving the article. Please try again"
    case alreadyInBookmarks = "You've already saved this article"
}
