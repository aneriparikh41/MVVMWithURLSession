//
//  NewsViewModel.swift
//  MVVMDemo
//
//  Created by Aneri Parikh on 23/04/22.
//

import Foundation

protocol NewsViewModelProtocol {
    func fetchNews()

    var news: News? { get }

    var newsPopulated: () -> () { get }

    var errorOccured: Bool { get }
}

class NewsViewModel: NewsViewModelProtocol {

    let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=b1008ff47f594f0e8140cb84d0f230e7"
    private var service: ServiceLayer?
    var newsPopulated: () -> () = {}
    var errorOccured: Bool = false

    var news: News? {
        didSet {
            newsPopulated()
        }
    }

    init(service: Service) {
        self.service = service
    }

    func fetchNews() {
        service?.fetchNews(urlString: urlString) {[weak self] data, error in
            guard let self = self else { return }
            if let data = data {
                self.news = data
                self.errorOccured = false
            } else {
                if data == nil {
                    self.errorOccured = true
                    self.newsPopulated()
                }
            }
        }
    }
}
