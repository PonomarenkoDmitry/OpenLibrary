//
//  BooksViewModel.swift
//  OpenLibrary
//
//  Created by Дмитрий Пономаренко on 28.04.23.
//

import Foundation

class BooksViewModel {
    
    var books: [Books] = []
    
    var eventHandler: ((_ event: Event) -> ())?
    
    func fetchBooks() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchData { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let books):
                    self.books.append(books)
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension BooksViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
