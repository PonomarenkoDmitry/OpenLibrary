//
//  APIManager.swift
//  OpenLibrary
//
//  Created by Дмитрий Пономаренко on 28.04.23.
//

import Foundation

enum DataError: Error {
case invalidResponse
case invalidData
case invalidURL
case network(_ error: Error?)
}


final class APIManager {
    
    static let shared = APIManager()
    private init() { }
    
    func fetchData(complition: @escaping ((Result<Books, DataError>) -> ())) {
        for i in Constant.arr {
            guard let url = URL(string: "https://openlibrary.org/works/\(i).json") else {
                complition(.failure(.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data, error == nil else {
                    complition(.failure(.invalidData))
                    return
                }
                guard let response = response as? HTTPURLResponse, 200 ... 499 ~= response.statusCode else {
                    complition(.failure(.invalidResponse))
                    return
                }
                do {
                    let booksData = try JSONDecoder().decode(Books.self, from: data)
                        complition(.success(booksData))
                } catch {
                    complition(.failure(.network(error)))
                }
                
            }
            task.resume()
        }
    }
}
