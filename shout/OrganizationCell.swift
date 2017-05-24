//
//  OrganizationCell.swift
//  shout
//
//  Created by Phillip Lisovicz on 5/23/17.
//  Copyright © 2017 Phillip Lisovicz. All rights reserved.
//

import UIKit
import SwiftyJSON
import FontAwesomeKit


class OrganizationCell: UITableViewCell {


    @IBOutlet var orgNameLabel: UILabel!

    @IBOutlet var ratingView: UIView!
    @IBOutlet var ratingLabel: UILabel!
    
    @IBOutlet var positiveView: UIView!
    @IBOutlet var positiveLabel: UILabel!
    
    @IBOutlet var negativeView: UIView!
    @IBOutlet var negativeLabel: UILabel!
    

  var json: JSON = nil {
      didSet {
        print("yoyoyo")
        self.orgNameLabel.text="FTHIS"

        self.ratingLabel.text="0stars"
        self.orgNameLabel.text="FTHIS"
        self.positiveLabel.text="26 positive shouts"
        self.negativeLabel.text="305 negative shouts"
      }

  }
}
