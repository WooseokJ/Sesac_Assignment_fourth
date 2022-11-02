//
//  Person.swift
//  Unsplash
//
//  Created by useok on 2022/10/31.
//

import Foundation

struct Person: Codable {
    let page, totalPages,totalResult: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case page,results
        case totalPages = "total_pages"
        case totalResult = "total_results"
        
    }
}

struct Result: Codable {
    let knowForDepartment, name: String
    
    enum codingKeys: String, CodingKey {
        case name
        case knowForDepartment = "know_for_department" // 원하는형태대로 만들려고
    }
}
