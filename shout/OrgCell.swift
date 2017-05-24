//
//  OrgCell.swift
//  shout
//
//  Created by Phillip Lisovicz on 5/23/17.
//  Copyright © 2017 Phillip Lisovicz. All rights reserved.
//

import UIKit
import SwiftyJSON
import FontAwesomeKit


class OrgCell: UITableViewCell {

  var json: JSON = nil {
      didSet {
        print("setting ORG CELL")
        // self.orgNameLabel.text = "YO ORG NAME"
      }

  }
}
