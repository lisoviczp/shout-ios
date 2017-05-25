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


    @IBOutlet var favoriteButton: UIButton!

    @IBOutlet var watchButton: UIButton!

  var json: JSON = nil {
      didSet {
        self.orgNameLabel.text = json["name"].string!
        self.ratingLabel.text  = "Shout score: \(json["rating"].int!)!"
        self.positiveLabel.text = "\(json["positive_count"].int!) positive reviews"
        self.negativeLabel.text = "\(json["negative_count"].int!) negative reviews"
      }

  }

    @IBAction func onFavorite(_ sender: Any) {
        print("on favorite..")
    }

    @IBAction func onFollow(_ sender: Any) {
        print("on follow..")

    }



}
