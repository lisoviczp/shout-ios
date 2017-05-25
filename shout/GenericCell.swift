//
//  GenericCell.swift
//  shout
//
//  Created by Phillip Lisovicz on 5/24/17.
//  Copyright © 2017 Phillip Lisovicz. All rights reserved.
//

import UIKit
import SwiftyJSON

class GenericCell: UITableViewCell {


    @IBOutlet var mainLabel: UILabel!


  var json: JSON = nil {
      didSet {
        self.mainLabel.text = json["name"].string!
      }

  }
}
