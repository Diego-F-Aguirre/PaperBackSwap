//
//  BookTableViewCell.swift
//  PaperBackSwap_Breakdown
//
//  Created by Diego Aguirre on 7/27/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookCoverImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookRating: UILabel!
 
    
    func updateBookCell(book: Book) {
        bookTitle.text = book.title
        bookAuthor.text = book.author
        bookRating.text = book.rating
        
        ImageController.imageForURL(book.imageEndpoint) { (image) in
            self.bookCoverImage.image = image
        }
    }
}
