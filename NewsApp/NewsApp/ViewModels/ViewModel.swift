//
//  ViewModel.swift
//  NewsApp
//
//  Created by Yusuf Emirhan Arslan on 13.05.2023.
//

import Foundation
import NewsAppAPI

protocol ViewModelProtocol {
    
    var numberOfItems: Int {get}
    var delegate: ViewModelDelegate? {get set}
    
    func fetchData()
}

protocol ViewModelDelegate: AnyObject {
    
    
}

final class ViewModel{
   
      let service: NewsServiceProtocol
      weak var delegate: ViewModelDelegate?
      var news: NewsModel!
    
    init(service: NewsServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchNews() {
        
        service.fetchNews(value: "books") { response in
            
            switch response {
                
            case .success(let news):
                self.news = news
                print("News = \(news.results)")
            case .failure(let error):
                print("Error = \(error.localizedDescription)")
            }
        }
    }
    
}




extension ViewModel: ViewModelProtocol {
    
    func fetchData() {
        fetchNews()
    }
    
    
    var numberOfItems: Int {
        news.results!.count
    }
    
    
}

