//
//  ListPhoto.swift
//  Unsplash
//
//  Created by useok on 2022/10/31.
//

import Foundation

// MARK: - ListPhotoElement
struct ListPhoto: Codable,Hashable {
    let listPhotoDescription: String
    let urls: [Urls]

    enum CodingKeys: String, CodingKey {
        case listPhotoDescription = "description"
        case urls
    }
}

// MARK: - Urls
struct Urls: Codable , Hashable{
    let thumb: String
    
}

