//
//  Service.swift
//  MVVMDemo
//
//  Created by Aneri Parikh on 23/04/22.
//

import Foundation

protocol ServiceLayer {
    func fetchNews(urlString: String, completion: @escaping (News?, Error?) -> ())
}

class Service: ServiceLayer {
    func fetchNews(urlString: String, completion: @escaping (News?, Error?) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(nil, NewsError.invalidURL)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(nil, NewsError.generic)
                return
            }

            if let newsData = try? JSONDecoder().decode(News.self, from: data) {
                completion(newsData, nil)
            } else {
                completion(nil, NewsError.parsingError)
            }
        }.resume()
    }
}

