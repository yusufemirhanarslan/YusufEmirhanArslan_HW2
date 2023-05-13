//
//  Decoders.swift
//  
//
//  Created by Yusuf Emirhan Arslan on 13.05.2023.
//

import Foundation

public enum Decoders {
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}
