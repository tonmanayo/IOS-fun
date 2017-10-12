//
//  TweetTableViewCell.swift
//  smashTag
//
//  Created by Tony MACK on 2017/10/12.
//  Copyright © 2017 Tony MACK. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var postDate: UILabel!

    @IBOutlet weak var tweeterName: UILabel!
    @IBOutlet weak var tweeterTweet: UILabel!
    
    var tweet: Twitter.Tweet? {didSet {updateUI()}}
    
    private func updateUI() {
        tweeterTweet.text = tweet?.text
        tweeterName.text = tweet?.user.description
        
        if let profileImageURL = tweet?.user.profileImageURL{
        
            if let imageData = try? Data(contentsOf: profileImageURL) {
                profilePic?.image = UIImage(data: imageData)
            } else {
                profilePic?.image = nil
            }
            
            if let created = tweet?.created {
                let formatter = DateFormatter()
                if Date().timeIntervalSince(created) > 24*60*60 {
                    formatter.dateStyle = .short
                } else {
                    formatter.timeStyle = .short
                }
                postDate?.text = formatter.string(from: created)
            } else {
                postDate?.text = nil
            }
            
         }
    }
}
