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
          self.orgNameLabel.text = "YO ORG NAME"
          self.reviewLabel.text = "0stars"
          self.reviewBodyLabel.text = "yothisplacesucksyothisplacesucksyothisplacesucksyothisplacesucksyothisplacesucksyothisplacesucks"
          self.usernameLabel.text = "phillslife"
        }

    }
}
