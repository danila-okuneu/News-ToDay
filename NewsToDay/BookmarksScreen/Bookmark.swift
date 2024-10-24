import UIKit

struct Bookmark {
    let articleImage: String
    let categories: String
    let description: String
}

struct BookmarksTests {
    static var data = [
        Bookmark(articleImage: "chinatown", categories: "UI/UX Design", description: "A Simple Trick For Creating Color Palettes Quickly asd ASDSDS asda s ASD ASD sa dSD ASD AS"),
        Bookmark(articleImage: "handLuggage", categories: "Art", description: "Six steps to creating a color palette"),
        Bookmark(articleImage: "timesquare", categories: "Colors", description: "Creating Color Palette from world around you"),
        Bookmark(articleImage: "chinatown", categories: "UI/UX Design", description: "A Simple Trick For Creating Color Palettes Quickly"),
    ]
}
