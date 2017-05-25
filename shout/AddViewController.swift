//
//  AddViewController.swift
//  shout
//
//  Created by Phillip Lisovicz on 5/21/17.
//  Copyright © 2017 Phillip Lisovicz. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {


    @IBOutlet var pageHeaderLabel: UILabel!
    @IBOutlet var pageHeaderView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var tagCompanyButton: UIButton!
    @IBOutlet var editView: UIView!

    @IBOutlet var tagTagsButton: UIButton!
    @IBOutlet var tagReasonButton: UIButton!

    @IBOutlet var reviewTextView: UITextView!

    @IBOutlet var natureTableView: UITableView!
    @IBOutlet var reasonTableView: UITableView!

    var companyName: String = ""
    var companyId: Int = 0

    var reasonName: String = ""
    var reasonId: Int = 0

    var categoryName: String = ""
    var categoryId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardDidShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.keyboardDidShow(_:)), name:NSNotification.Name.UIKeyboardDidShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);


        self.pageHeaderLabel.text = "Add Review"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewWillAppear(_ animated: Bool) {
      self.reviewTextView.becomeFirstResponder()
      print("\n\nAddViewController view appearing.. printing variables")
      // print(self.companyName)
      // print(self.companyId)
      if self.companyId > 0 {
        self.tagCompanyButton.setTitle(self.companyName, for: UIControlState.normal)
      }
    }

    func textViewDidBeginEditing(textField: UITextView) {
    }

    func keyboardWillShow(_ notification: Notification) {
      self.cancelButton.isHidden = false
    }

    func keyboardDidShow(_ notification: Notification) {
      let keyboardHeight = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.height
    }

    func keyboardWillHide(_ notification: Notification) {
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if tableView == self.natureTableView {
        return Shout.session.reviewCategories.count
      }

      return Shout.session.reviewReasons.count

    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.natureTableView {
          let categoryCellJSON = Shout.session.reviewCategories[indexPath.row]
          let categoryCell:GenericCell = tableView.dequeueReusableCell(withIdentifier: "GenericCell") as! GenericCell
          categoryCell.layoutMargins = UIEdgeInsets.zero
          categoryCell.json = categoryCellJSON
          categoryCell.selectionStyle = .none
          return categoryCell
        }

        let reasonCellJSON = Shout.session.reviewReasons[indexPath.row]
        let reasonCell:GenericCell = tableView.dequeueReusableCell(withIdentifier: "GenericCell") as! GenericCell
        reasonCell.layoutMargins = UIEdgeInsets.zero
        reasonCell.json = reasonCellJSON
        reasonCell.selectionStyle = .none
        return reasonCell

    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if tableView == self.natureTableView {
        self.natureTableView.isHidden = true
        self.categoryName = Shout.session.reviewCategories[indexPath.row]["name"].string!
        self.categoryId = Shout.session.reviewCategories[indexPath.row]["id"].int!
        self.tagTagsButton.setTitle(self.categoryName, for: UIControlState.normal)
      } else {
        self.reasonTableView.isHidden = true
        self.reasonName = Shout.session.reviewReasons[indexPath.row]["name"].string!
        self.reasonId = Shout.session.reviewReasons[indexPath.row]["id"].int!
        self.tagReasonButton.setTitle(self.reasonName, for: UIControlState.normal)
      }
      // let cellJSON = Shout.session.companies[indexPath.row]
      // self.companyName = cellJSON["name"].string!
      // self.companyId = cellJSON["id"].int!
      // print("pressing..companyid \(self.companyId)")
      // self.performSegue(withIdentifier: "orgSelectToAddReview", sender: self)
    }



    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }



    func tableView(_ tableView: UITableView, willDisplay cell:UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white
    }


    @IBAction func onComplaintSelect(_ sender: Any) {
        self.reviewTextView.resignFirstResponder()
        if self.natureTableView.isHidden {
          self.natureTableView.isHidden = false
          self.view.bringSubview(toFront: self.natureTableView)
        } else {
          self.natureTableView.isHidden = true
        }
    }

    @IBAction func onReason(_ sender: Any) {
        self.reviewTextView.resignFirstResponder()
        if self.reasonTableView.isHidden {
          self.reasonTableView.isHidden = false
          self.view.bringSubview(toFront: self.reasonTableView)
        } else {
          self.reasonTableView.isHidden = true
        }
    }

    @IBAction func onShare(_ sender: Any) {
        self.reviewTextView.resignFirstResponder()
        Shout.client.createReview(self.reviewTextView.text, company_id: self.companyId, review_rating: 5, review_reason_id: self.reasonId, review_category_id: self.categoryId, handler: { json in } )
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContainerTabBarViewController")
        self.show(vc, sender: self)

    }


    @IBAction func onCancel(_ sender: Any) {
        self.reviewTextView.text = ""
        self.reviewTextView.resignFirstResponder()
        self.cancelButton.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContainerTabBarViewController")
        self.show(vc, sender: self)
    }


}
