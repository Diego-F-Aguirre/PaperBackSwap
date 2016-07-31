//
//  RecentBookListTableViewController.swift
//  PaperBackSwap_Breakdown
//
//  Created by Diego Aguirre on 7/27/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class RecentBookListTableViewController: UITableViewController, BookControllerDelegate {
    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookController.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookController.books.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("bookCell", forIndexPath: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = bookController.books[indexPath.row]
        
        cell.updateBookCell(book)
        
        return cell
    }
    
    func fetchedBooks(books: [Book]) {
        tableView.reloadData()
    }
}
