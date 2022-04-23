//
//  Parser.swift
//  MVVMDemo
//
//  Created by Aneri Parikh on 23/04/22.
//

import Foundation

// not needed here
class Parser {
    static let shared = Parser()
    fileprivate init() {}

    func parse(json: [[String: Any]]) -> News? {

        var news = [NewsInfo]()
        for element in json {
            if let title = element["title"] as? String,
               let imageURL = element["urlToImage"] as? String,
               let desc = element["description"] as? String,
               let newsURL = element["url"] as? String {
                let newObj = NewsInfo(title: title, imageURL: imageURL, desc: desc, newsURL: newsURL)
                news.append(newObj)
            }
        }
        return News(news: news)
    }
}
