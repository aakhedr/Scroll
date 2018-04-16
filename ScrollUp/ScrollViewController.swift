//
//  ScrollViewController.swift
//  ScrollUp
//
//  Created by Ahmed Khedr on 4/16/18.
//  Copyright © 2018 Ahmed Khedr. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var searchController: UISearchController!
    fileprivate var intitialScrollViewContentOffset: CGPoint!
    
    fileprivate var datasource = [String]()
    fileprivate var searchResults = [String]()

    fileprivate let numberOfRows: Int = 50
    fileprivate let cellReuseIdentifier = "cell"
    fileprivate let searchBarPlaceholderText = "Search"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchController()
        tableView.dataSource = self
        
        for i in 0..<numberOfRows {
            datasource.append("iPhone \(i)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        intitialScrollViewContentOffset = tableView.contentOffset
    }
    
    // MARK:- Scroll up
    @IBAction func scrollUp(_ sender: UIBarButtonItem) {
        tableView.setContentOffset(intitialScrollViewContentOffset, animated: true)
    }
    
    // MARK:- Scroll down
    @IBAction func scrollDown(_ sender: UIBarButtonItem) {
        let bottomPoint = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.height)
        tableView.setContentOffset(bottomPoint, animated: true)
    }
}

// MARK:- Table View Datasource
extension ScrollViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchController = searchController else { return 0 }
        
        if searchController.isActive {
            return searchResults.count
        }
        
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        guard let searchController = searchController else { return cell }
        
        switch searchController.isActive {
        case true:
            cell.textLabel?.text = searchResults[indexPath.row]
        case false:
            cell.textLabel?.text = datasource[indexPath.row]
        }
        
        return cell
    }
}

// MARK:- Heleprs
extension ScrollViewController {
    fileprivate func addSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = searchBarPlaceholderText
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.sizeToFit()
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

// MARK:- UISearchResutlsUpdating
extension ScrollViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        searchResults = datasource.filter { $0.contains(searchText) }
        tableView.reloadData()
    }
}
