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
    
    fileprivate var datasource: [String] = [String]()
    fileprivate var intitialScrollViewContentOffset: CGPoint!
    
    fileprivate let numberOfRows: Int = 50
    fileprivate let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = datasource[indexPath.row]
        return cell
    }
}
