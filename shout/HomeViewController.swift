//
//  HomeViewController.swift
//  shout
//
//  Created by Phillip Lisovicz on 5/21/17.
//  Copyright © 2017 Phillip Lisovicz. All rights reserved.
//

import UIKit
import SwiftyJSON
import FontAwesomeKit

class HomeViewController: UIViewController, UITableViewDelegate, UITextViewDelegate, UITableViewDataSource, UINavigationControllerDelegate  {

    @IBOutlet var tableView: UITableView!

    var sampleJSON: JSON = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // add pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl)


        // need these to make the cell height adjust to the content, provided each text box is bound by constraints to its cell
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension

    }

    override func viewWillAppear(_ animated: Bool) {
        self.refresh()
    }

    func refresh(_ refreshControl: UIRefreshControl? = nil) {
      print("calling reviews at the beginning...")
      Shout.client.getRelevantReviews({ json in
        Shout.session.relevantReviews = json["reviews"].array!
        refreshControl?.endRefreshing()
        self.tableView.layoutIfNeeded()
        self.tableView.reloadData()
      })
    }


    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shout.session.relevantReviews.count
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // self.sampleJSON["body"] = "ayy whassup"
        // var cellJSON = self.sampleJSON
        let cellJSON = Shout.session.relevantReviews[indexPath.row]

        var reviewCell = Bundle(for:object_getClass(self)).loadNibNamed("ReviewCell", owner: nil, options: nil)![0] as! ReviewCell
        reviewCell.layoutMargins = UIEdgeInsets.zero
        reviewCell.json = cellJSON
        reviewCell.selectionStyle = .none

        return reviewCell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }



    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }



    func tableView(_ tableView: UITableView, willDisplay cell:UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white
    }


}
