//
//  OrgSelectViewController.swift
//  shout
//
//  Created by Phillip Lisovicz on 5/23/17.
//  Copyright © 2017 Phillip Lisovicz. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrgSelectViewController: UIViewController, UITableViewDelegate, UITextViewDelegate, UITableViewDataSource, UINavigationControllerDelegate  {


    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var pageHeaderLabel: UILabel!

    @IBOutlet var searchField: UITextField!


    @IBOutlet var tableView: UITableView!

    var sampleJSON: JSON = [:]
    var companyName: String = ""
    var companyId: Int = 0


    var loading: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shout.session.companies.count
    }


    func refresh(_ refreshControl: UIRefreshControl? = nil) {

        print("Ay refreshing..")
        // refreshControl?.endRefreshing()
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.sampleJSON["body"] = "ayy whassup OrgCell"
        // let cellJSON = self.sampleJSON
        let cellJSON = Shout.session.companies[indexPath.row]

        var orgCell = Bundle(for:object_getClass(self)).loadNibNamed("OrgOverviewCell", owner: nil, options: nil)![0] as! OrgOverviewCell
        orgCell.layoutMargins = UIEdgeInsets.zero
        orgCell.json = cellJSON
        orgCell.selectionStyle = .none
        return orgCell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print("pressing..")
      let cellJSON = Shout.session.companies[indexPath.row]
      self.companyName = cellJSON["name"].string!
      self.companyId = cellJSON["id"].int!
      print("pressing..companyid \(self.companyId)")
      self.performSegue(withIdentifier: "orgSelectToAddReview", sender: self)
    }



    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }



    func tableView(_ tableView: UITableView, willDisplay cell:UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white
    }


    func load() {
        let search = self.searchField.text!.lowercased()
        self.loading = true
        //
        // Force.client.getCompanies(Shout.session.companies.count, term: search, handler: { json in
        //     Force.session.cases.append(contentsOf: json["cases"].array!)
        //     self.tableView.reloadData()
        //     self.loading = false
        // })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Segway..")
        print(self.companyName)
        print(self.companyId)
       if segue.identifier == "orgSelectToAddReview" {
         print("yes...")
          let vc = segue.destination as! AddViewController
          print(self.companyId)
          vc.companyName = self.companyName
          vc.companyId = self.companyId
          // self.dismiss(animated: true, completion: nil)
       }
    }

    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func onSearch(_ sender: AnyObject) {
        self.refresh()
    }


}
