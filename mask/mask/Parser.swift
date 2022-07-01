//
//  Parser.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import Foundation

struct SuccessParser<T: Codable>: Codable {

    let data: T

    
    enum CodingKeys: String, CodingKey {
        
        case data
        
        
    }
}

struct FailureParser: Codable {

    let errorMessage: String
}
