//
//  ContainerTabBarViewController.swift
//  shout
//
//  Created by Phillip Lisovicz on 5/23/17.
//  Copyright © 2017 Phillip Lisovicz. All rights reserved.


import UIKit
import FontAwesomeKit

class ContainerTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("calling at the beginning...")
        Shout.client.getCompanies({ json in
          print("Calling getCompanies from Swift...")
          print(json)
          Shout.session.companies = json["data"].array!
        })
        self.viewControllers![0].tabBarItem.image = FAKFontAwesome.homeIcon(withSize: 20).image(with: CGSize(width: 20.0, height: 20.0))
        self.viewControllers![1].tabBarItem.image = FAKFontAwesome.calendarIcon(withSize: 20).image(with: CGSize(width: 20.0, height: 20.0))
        self.viewControllers![2].tabBarItem.image = FAKFontAwesome.plusSquareOIcon(withSize: 20).image(with: CGSize(width: 20.0, height: 20.0))
        self.viewControllers![3].tabBarItem.image = FAKFontAwesome.newspaperOIcon(withSize: 20).image(with: CGSize(width: 20.0, height: 20.0))
        self.viewControllers![4].tabBarItem.image = FAKFontAwesome.microphoneIcon(withSize: 20).image(with: CGSize(width: 20.0, height: 20.0))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
