//
//  File.swift
//  
//
//  Created by Yusuf Emirhan Arslan on 13.05.2023.
//

import Foundation


public struct News: Decodable {
    
   public let section: String?
   public let subsection: String?
   public let title: String?
   public let abstract: String?
   public let url: String?
   public let byline: String?
   public let multimedia: [Multimedia]?
}
