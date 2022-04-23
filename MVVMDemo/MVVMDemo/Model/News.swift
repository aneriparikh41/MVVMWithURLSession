//
//  News.swift
//  MVVMDemo
//
//  Created by Aneri Parikh on 23/04/22.
//

import Foundation

struct News: Codable {
    let news: [NewsInfo]

    enum CodingKeys: String, CodingKey {
        case news = "articles"
    }
}

struct NewsInfo: Codable {
    let title: String
    let imageURL: String
    let desc: String
    let newsURL: String

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "urlToImage"
        case desc = "description"
        case newsURL = "url"
    }
}

enum NewsError: Error {
    case invalidURL
    case generic
    case parsingError
}
