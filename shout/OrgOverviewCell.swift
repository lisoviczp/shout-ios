//
//  OrgOverviewCell.swift
//  shout
//
//  Created by Phillip Lisovicz on 5/23/17.
//  Copyright © 2017 Phillip Lisovicz. All rights reserved.
//

import UIKit
import SwiftyJSON
import FontAwesomeKit

class OrgOverviewCell: UITableViewCell {


  @IBOutlet var orgNameLabel: UILabel!

  var json: JSON = nil {
      didSet {
        // print("setting ORGOVERVIEW CELL: \(json)")
         self.orgNameLabel.text = json["name"].string!
      }

  }
}
