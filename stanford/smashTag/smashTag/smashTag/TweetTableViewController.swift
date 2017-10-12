//
//  TweetTableViewController.swift
//  smashTag
//
//  Created by Tony MACK on 2017/10/12.
//  Copyright © 2017 Tony MACK. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewController: UITableViewController {

    private var tweets = [Array<Twitter.Tweet>]() {
        didSet {
            print(tweets)
        }
    }
    
    var searchText: String? {
        didSet {
            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
            title = searchText
        }
    }
    
    private func twitterRequest() -> Twitter.Request? {
        if let query = searchText, !query.isEmpty {
            return Twitter.Request(search: query, count: 100)
        }
        return nil
    }
    private var lastTwitetrRequest: Twitter.Request?
    private func searchForTweets() {
        if let request = twitterRequest() {
            DispatchQueue.main.async {
                self.lastTwitetrRequest = request
                request.fetchTweets { [weak self] newTweets in
                    if request == self?.lastTwitetrRequest {
                        self?.tweets.insert(newTweets, at: 0)
                        self?.tableView.insertSections([0], with: .fade)                    }
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight  = UITableViewAutomaticDimension
        searchText = "#angus"
        }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        
       let tweet: Tweet  = tweets[indexPath.section][indexPath.row]
        if let tweetCell = cell as? TweetTableViewCell {
                tweetCell.tweet = tweet
        }
        return cell
    }
}
