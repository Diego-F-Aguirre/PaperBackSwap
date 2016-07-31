//
//  Book.swift
//  PaperBackSwap_Breakdown
//
//  Created by Diego Aguirre on 7/27/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

struct Book {
    private let kTitle = "Title"
    private let kAuthor = "Author"
    private let kAuthors = "Authors"
    private let kRating = "Rating"
    private let kCoverImages = "CoverImages"
    private let kImage = "MediumImage"
    
    let title: String
    let author: String
    let rating: String
    let imageEndpoint: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let title = dictionary[kTitle] as? String,
            authors = dictionary[kAuthors] as? [String: AnyObject],
            author = authors[kAuthor] as? String,
            rating = dictionary[kRating] as? String,
            coverImages = dictionary[kCoverImages] as? [String: AnyObject],
            image = coverImages[kImage] as? String else { return nil }
        
        self.title = title
        self.author = author
        self.rating = rating
        self.imageEndpoint = image
    }
}