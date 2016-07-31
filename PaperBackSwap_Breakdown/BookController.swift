//
//  BookController.swift
//  PaperBackSwap_Breakdown
//
//  Created by Diego Aguirre on 7/27/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class BookController {
    
    static let baseURL = NSURL(string: "http://www.paperbackswap.com/api/v2/index.php?")
    
    weak var delegate: BookControllerDelegate?
    
    var books: [Book] = [] {
        didSet {
            delegate?.fetchedBooks(books)
        }
    }
    
    init() {
        fetchRecentBooks { (books) in
            self.books = books 
        }
    }
    
    func fetchRecentBooks(completion: ((books: [Book]) -> Void)?) {
        
        guard let completion = completion else { return }
        
        guard let url = BookController.baseURL else {
            print("Error: No URL found")
            completion(books: [])
            return
        }
        
        let parameters = ["RequestType": "RecentlyPosted"]
        
        NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: parameters, body: nil) { (data, error) in
            guard let data = data,
                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                    print("Error: No Data was found")
                    completion(books: [])
                    return
            }
            
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject],
                let responseDictionary = jsonDictionary["Response"] as? [String: AnyObject],
                booksDictionary = responseDictionary["Books"] as? [String: AnyObject],
                bookDictionaryArray = booksDictionary["Book"] as? [[String: AnyObject]] else {
                    print("Error: JSON serialization failed: /n\(responseDataString)")
                    completion(books: [])
                    return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let books = bookDictionaryArray.flatMap {Book(dictionary: $0)}
                self.books = books
                completion(books: books)
                
                for book in books {
                    print("\(book.title)/n\(book.author)/n\(book.rating)/n\(book.imageEndpoint)")
                }
            })
        }
    }
}

protocol BookControllerDelegate: class {
    func fetchedBooks(books: [Book])
}