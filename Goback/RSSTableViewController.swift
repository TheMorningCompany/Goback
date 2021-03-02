//
//  RSSTableViewController.swift
//  Goback
//
//  Created by Julian Wright on 3/3/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit
import SafariServices

import UIKit
import SafariServices

class NewsTableViewController: UITableViewController, SFSafariViewControllerDelegate
{
    
    private var rssItems: [RSSItem]?
    private var cellStates: [CellState]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 176
        tableView.rowHeight = UITableView.automaticDimension
        
        fetchData()
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176
    }
    
    private func fetchData() {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://developer.apple.com/news/rss/news.rss") { (rssItems) in
            self.rssItems = rssItems
            self.cellStates = Array(repeating: .collapsed, count: rssItems.count)
            
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .bottom)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RSScell", for: indexPath) as! NewsTableViewCell
        if let item = rssItems?[indexPath.item] {
            cell.item = item
            
            if let cellStates = cellStates {
                cell.descriptionLabel.numberOfLines = (cellStates[indexPath.row] == .expanded) ? 0 : 2
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "") { (action, view, completion) in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.textLabel?.textColor = UIColor(named: "Completed")
            
            do {
                completion(true)
                let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
                let link = cell.item.link
                let urlToGo = URL(string: "\(link)")
                
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = false
                let vc = SFSafariViewController(url: urlToGo!, configuration: config)
                self.present(vc, animated: true)
                
                print(cell.item.link)
                
            } catch {
                completion(false)
            }
        }
        action.image = UIImage(systemName: "rectangle.expand.vertical")?.withTintColor(UIColor(named: "Green")!, renderingMode: .alwaysOriginal)
        action.backgroundColor = UIColor(named: "BG")
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        
        tableView.beginUpdates()
        cell.descriptionLabel.numberOfLines = (cell.descriptionLabel.numberOfLines == 0) ? 3 : 0
        cell.titleLabel.numberOfLines = (cell.titleLabel.numberOfLines == 1) ? 0 : 1
        
        UIView.animate(withDuration: 0.4) {
            cell.bgView.alpha = (cell.bgView.alpha == 1) ? 0 : 1
        }
        
        
        cellStates?[indexPath.row] = (cell.descriptionLabel.numberOfLines == 0) ? .expanded : .collapsed
        
        tableView.endUpdates()
    }


}
