//
//  NewsResponse.swift
//  
//
//  Created by Yusuf Emirhan Arslan on 13.05.2023.
//

import Foundation

public struct NewsResponse: Decodable {
    
    public let results: NewsModel
    
    private enum RootCodingKeys: String, CodingKey {
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try container.decode(NewsModel.self, forKey: .results)
    }
    
    
}
