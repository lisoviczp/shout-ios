//
//  ReviewCell.swift
//  shout
//
//  Created by Phillip Lisovicz on 5/21/17.
//  Copyright © 2017 Phillip Lisovicz. All rights reserved.
//

import UIKit
import SwiftyJSON
import FontAwesomeKit


class ReviewCell: UITableViewCell {


    @IBOutlet var orgNameLabel: UILabel!
    @IBOutlet var ratingView: UIView!
    @IBOutlet var reviewLabel: UILabel!
    @IBOutlet var reviewBodyLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!

    var json: JSON = nil {
        didSet {
          // print("From cell...")
          // print(json)
          self.orgNameLabel.text = json["company"]["name"].string!
          self.reviewLabel.text = "\(json["review_rating"].int!)"
          self.reviewBodyLabel.text = json["body"].string!
          self.usernameLabel.text = json["user"]["username"].string!
        }

    }
}
