//
//  BooksData.swift
//  OpenLibrary
//
//  Created by Дмитрий Пономаренко on 28.04.23.
//

import Foundation


struct Books: Codable {
    
    let title: String
    let description: String
    let covers: [Int]
    let created: Created
}

struct Created: Codable {
    
    let type: String
    let value: String
}
