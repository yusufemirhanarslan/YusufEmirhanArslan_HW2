//
//  File.swift
//  
//
//  Created by Yusuf Emirhan Arslan on 13.05.2023.
//

import Foundation
import Alamofire


public protocol NewsServiceProtocol: AnyObject {
    
    func fetchNews(value: String, completion: @escaping(Result<NewsModel,Error>) -> Void)
    
}

public class NewsService: NewsServiceProtocol {
    
    public init() {}
    
    public func fetchNews(value: String, completion: @escaping (Result<NewsModel, Error>) -> Void) {
        
        let urlString = Constants.baseUrl + "\(value)" + Constants.secondUrl + Constants.apiKey
        
        AF.request(urlString).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                
                let decoder = Decoders.decoder
                
                do {
                        
                    let news = try decoder.decode(NewsModel.self, from: data)
                        completion(.success(news))
                        
                    }catch {
                        print("****** JSON DECODE ERROR *******")
                    }
                
                
                
            case .failure(let error):
                print("****** GEÇİCİ BİR HATA OLUŞTU: \(error.localizedDescription)")
            }
        }
    }
}

extension NewsService {
    
    enum Constants {
        
        static let baseUrl = "https://api.nytimes.com/svc/topstories/v2/"
        static let secondUrl = ".json?api-key="
        static let apiKey = "ViHz0NYChG8mxJk7BWxHwOurDXtPGLaw"
    }
    
}
