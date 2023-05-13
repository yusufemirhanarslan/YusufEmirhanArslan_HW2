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
    var segmentedCount: Int {get}
    
    func fetchData(value: String)
    func setSegmentedControl(index: Int) -> String
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
    
    fileprivate func fetchNews(value: String) {
        
        service.fetchNews(value: value) { response in
            
            switch response {
                
            case .success(let news):
                self.news = news
                print("Value: \(value) \n Variable: \(news)")
            case .failure(let error):
                print("Error = \(error.localizedDescription)")
            }
        }
    }
    
    var segmentedControlName = ["arts", "automobiles", "books", "business", "fashion", "food", "health", "home", "insider", "magazine", "movies", "nyregion", "obituaries", "opinion", "politics", "realestate", "science", "sports", "sundayreview", "technology", "theater", "t-magazine", "travel", "upshot", "us", "world"]
        
    
}


extension ViewModel: ViewModelProtocol {
    
    var segmentedCount: Int {
        segmentedControlName.count
    }
    
    
    func setSegmentedControl(index: Int) -> String {
        return segmentedControlName[index]
    }
    
    
    func fetchData(value: String) {
        fetchNews(value: value)
    }
    
    
    var numberOfItems: Int {
        news.results!.count
    }
    
    
}

