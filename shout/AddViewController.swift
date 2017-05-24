//
//  AddViewController.swift
//  shout
//
//  Created by Phillip Lisovicz on 5/21/17.
//  Copyright © 2017 Phillip Lisovicz. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextViewDelegate {


    @IBOutlet var pageHeaderLabel: UILabel!
    @IBOutlet var pageHeaderView: UIView!


    @IBOutlet var cancelButton: UIButton!


    @IBOutlet var tagCompanyButton: UIButton!
    @IBOutlet var editView: UIView!

    @IBOutlet var tagTagsButton: UIButton!

    @IBOutlet var reviewTextView: UITextView!

    @IBOutlet var natureTableView: UITableView!
    @IBOutlet var reasonTableView: UITableView!

    var companyName: String = ""
    var companyId: Int = 0

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
      print(self.companyName)
      print(self.companyId)
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onComplaintSelect(_ sender: Any) {
        if self.natureTableView.isHidden {
          self.natureTableView.isHidden = false
          self.view.bringSubview(toFront: self.natureTableView)
        } else {
          self.natureTableView.isHidden = true
        }
    }

    @IBAction func onReason(_ sender: Any) {
        if self.reasonTableView.isHidden {
          self.reasonTableView.isHidden = false
          self.view.bringSubview(toFront: self.reasonTableView)
        } else {
          self.reasonTableView.isHidden = true
        }
    }

    @IBAction func onCancel(_ sender: Any) {
      self.reviewTextView.text = ""
      self.reviewTextView.resignFirstResponder()
      self.cancelButton.isHidden = true
    }


}
