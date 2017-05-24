//
//  ExploreViewController.swift
//  shout
//
//  Created by Phillip Lisovicz on 5/21/17.
//  Copyright © 2017 Phillip Lisovicz. All rights reserved.
//

import UIKit
import SwiftyJSON
import FontAwesomeKit

class ExploreViewController: UIViewController, UITableViewDelegate, UITextViewDelegate, UITableViewDataSource, UINavigationControllerDelegate  {


    @IBOutlet var tableView: UITableView!

    var sampleJSON: JSON = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl)


        // need these to make the cell height adjust to the content, provided each text box is bound by constraints to its cell
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        // self.tableView.layoutIfNeeded()
        // self.tableView.reloadData()

        self.refresh()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.refresh()
    }

    func refresh(_ refreshControl: UIRefreshControl? = nil) {
        refreshControl?.endRefreshing()
    }

    internal func numberOfSections(in tableView: UITableView) -> Int {
      //            return Wydo.session.days.count
        return 1
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Trying to set orgCell..")
        self.sampleJSON["body"] = "ayy whassup OrgCell"
        let cellJSON = self.sampleJSON

        var orgCell = Bundle(for:object_getClass(self)).loadNibNamed("OrganizationCell", owner: nil, options: nil)![0] as! OrganizationCell
        orgCell.layoutMargins = UIEdgeInsets.zero
        orgCell.json = cellJSON
        orgCell.selectionStyle = .none
        return orgCell
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
