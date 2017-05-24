//
//  Force.swift
//  force
//
//  Created by Dave Kong on 11/19/14.
//  Copyright (c) 2014 Force Therapeutics. All rights reserved.
//
import SwiftyJSON
import Alamofire
import SFHFKeychainUtils
import CoreLocation
// import FBSDKCoreKit
// import FBSDKLoginKit

struct Shout {
    static let DEV_HOST = "http://localhost:8000"


    static let shoutGreenColor = UIColor(red: 173/255.0, green: 255/255.0, blue: 47/255.0, alpha: 1)  //#ADFF2F

    static let NPS_TIMELINE = 90 // days
    static let PAGE_SIZE = 20
    static let SCROLL_BUFFER = 10

    let screenWidth: CGFloat = UIScreen.main.bounds.size.width

    static var host = DEV_HOST
    // static var host = LIVE_HOST


    static let API_TOKEN = "aaaaaaaa-bbbb-cccc-dddd-a19a532aa969"


    static var session: ShoutSession {
        struct Singleton {
            static let _session = ShoutSession()
        }
        return Singleton._session
    }

    static var client: ShoutClient {
        struct Singleton {
            static let _client = ShoutClient()
        }
        return Singleton._client
    }

    static func track(_ screen: String, _ category: String, _ action: String, _ label: String? = nil, _ value: NSNumber? = nil) {
//        let tracker = GAI.sharedInstance().defaultTracker
//        let builder = GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: label, value: value)
//        tracker.set(kGAIScreenName, value: screen)
//        tracker.send(builder.build() as [NSObject : AnyObject])
//        tracker.set(kGAIScreenName, value: nil)
    }

//
   static func getUsername() -> String? {
       let str = UserDefaults.standard.string(forKey: "username")
       print("loaded username: \(str)")
       return str
   }

    static func setUsername(_ username: String?) {
        print("storing username: \(username)")
        UserDefaults.standard.set(username, forKey: "username")
    }




   static func getPassword() -> String? {
       var password: String? = nil
       do {
           try password = SFHFKeychainUtils.getPasswordForUsername("Shout", andServiceName: "Shout")
           return password
       } catch {
           print("error retrieving PASSWORD from secure storage")
           return " "
       }
      //  print("Current password: \(password)")
       return password
   }

   static func setPassword(_ password: String) {
      print("Actually trying to save the password now...")
       do {
           try SFHFKeychainUtils.storeUsername("Shout", andPassword: password, forServiceName: "Shout", updateExisting: true)
           print("password saved, maybe?")
       } catch {
           print("error saving PASSWORD to secure storage")
       }
   }

    static func deletePassword() {
        do {
            try SFHFKeychainUtils.deleteItem(forUsername: "Shout", andServiceName: "Shout")
            print("Deleted password from secure storage..")
        } catch {
            print("error deleting PASSWORD from secure storage")
        }
    }
}




class ShoutSession {
    var user: JSON = nil
    var companies: [JSON] = []

    func clear() {

    }
}


class ShoutClient {
    var manager: SessionManager

    init() {
      var headers = SessionManager.defaultHTTPHeaders // this returns a copy
      headers["API-TOKEN"] = Shout.API_TOKEN

      let iOSVersion = UIDevice.current.systemVersion
      let appVersion: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"]! as! String
      let configuration = URLSessionConfiguration.default
      configuration.httpAdditionalHeaders = headers

      print("headers: \(headers)")

       self.manager = SessionManager(configuration: configuration)
    }

    func getCompanies(_ handler: @escaping (JSON) -> Void) {
        print("calling getCompanies")
        self.manager.request("\(Shout.host)/api/get_companies",
            parameters: nil)
            .response(
                 queue: DispatchQueue.main,
                 responseSerializer: DataRequest.jsonResponseSerializer(),
                 completionHandler: { (response) in
                     var responseJSON: JSON
                     if response.result.isFailure {
                         responseJSON = JSON.null
                     } else {
                         responseJSON = SwiftyJSON.JSON(response.result.value!)
                     }
                     DispatchQueue.main.async {
                       handler(responseJSON)

                     }
                 }
             )
        print("donecalling get companies...?")
    }



    func createActivity(_ body: String, activity_date: String, publicBool: Bool, tag_id: Int, tag2_id: Int, goal_id: Int, location_string: String, handler: @escaping (JSON) -> Void) {
        self.manager.request("\(Shout.host)/api/create_activity", method: .post,
            parameters: [
                "body": body,
                "activity_date": activity_date,
                "public": publicBool,
                "mobile_activitytag_id": tag_id,
                "mobile_activitytag2_id": tag2_id,
                "mobile_goal_id": goal_id,
                "location_string": location_string,
            ]
            )
            .response(
                 queue: DispatchQueue.main,
                 responseSerializer: DataRequest.jsonResponseSerializer(),
                 completionHandler: { (response) in
                     var responseJSON: JSON
                     if response.result.isFailure {
                         responseJSON = JSON.null
                     } else {
                         responseJSON = SwiftyJSON.JSON(response.result.value!)
                     }
                     DispatchQueue.main.async {
                       handler(responseJSON)

                     }
                 }
             )
        print("done?")
    }



    func toggleStarredActivity(_ activity_body: Int, handler: @escaping (JSON) -> Void) {
        print("calling toggleAtivity")
        self.manager.request("\(Shout.host)/api/toggle_starred_activity/", method: .post,
            parameters: [
                "id": activity_body,
            ]
            )
            .response(
                 queue: DispatchQueue.main,
                 responseSerializer: DataRequest.jsonResponseSerializer(),
                 completionHandler: { (response) in
                     var responseJSON: JSON
                     if response.result.isFailure {
                         responseJSON = JSON.null
                     } else {
                         responseJSON = SwiftyJSON.JSON(response.result.value!)
                     }
                     DispatchQueue.main.async {
                       handler(responseJSON)
                     }
                 }
             )
    }


    func login(_ username: String, _ password: String, handler: @escaping (JSON) -> Void) {
        self.manager.request("\(Shout.host)/api/login_user/", method: .post,
            parameters: [
                "username": username,
                "password": password,
                ]
            )
            .response(
                 queue: DispatchQueue.main,
                 responseSerializer: DataRequest.jsonResponseSerializer(),
                 completionHandler: { (response) in
                     var responseJSON: JSON
                     if response.result.isFailure {
                         responseJSON = JSON.null
                     } else {
                         responseJSON = SwiftyJSON.JSON(response.result.value!)
                     }
                     DispatchQueue.main.async {
                       handler(responseJSON)
                     }
                 }
             )
    }

    func signup(_ username: String, _ password: String, handler: @escaping (JSON) -> Void) {
        print("what the shit balls")
        self.manager.request("\(Shout.host)/api/sign_up_mobile/", method: .post,
            parameters: [
                "username": username,
                "password": password,
                ]
            )
            .response(
                 queue: DispatchQueue.main,
                 responseSerializer: DataRequest.jsonResponseSerializer(),
                 completionHandler: { (response) in
                     var responseJSON: JSON
                     if response.result.isFailure {
                         responseJSON = JSON.null
                     } else {
                         responseJSON = SwiftyJSON.JSON(response.result.value!)
                     }
                     DispatchQueue.main.async {
                       handler(responseJSON)
                     }
                 }
             )
    }


    func updateProfile(_ username: String, email: String, first_name: String, last_name: String, user_id: Int, handler: @escaping (JSON) -> Void) {
        self.manager.request("\(Shout.host)/settings/update_profile", method: .post,
            parameters: [
                "whaddoo_username": username,
                "email": email,
                "first_name": first_name,
                "last_name": last_name,
                "user_id": user_id,
                ]
            )
            .response(
                 queue: DispatchQueue.main,
                 responseSerializer: DataRequest.jsonResponseSerializer(),
                 completionHandler: { (response) in
                     var responseJSON: JSON
                     if response.result.isFailure {
                         responseJSON = JSON.null
                     } else {
                         responseJSON = SwiftyJSON.JSON(response.result.value!)
                     }
                     DispatchQueue.main.async {
                       handler(responseJSON)
                     }
                 }
             )
    }


    func logout(_ handler: @escaping (JSON) -> Void) {
        print("LOGGING OUT USER")
        self.manager.request("\(Shout.host)/api/logout/", method: .post,
            parameters: nil
            )
            .response(
                 queue: DispatchQueue.main,
                 responseSerializer: DataRequest.jsonResponseSerializer(),
                 completionHandler: { (response) in
                     var responseJSON: JSON
                     if response.result.isFailure {
                         responseJSON = JSON.null
                     } else {
                         responseJSON = SwiftyJSON.JSON(response.result.value!)
                     }
                     DispatchQueue.main.async {
                       handler(responseJSON)
                     }
                 }
             )
    }

    func getFBUser(_ fb_access_token: String, handler: @escaping (JSON) -> Void) {
        print("Shout.swift -- LOGGING IN FBuser")
        self.manager.request("\(Shout.host)/api/register-by-token/facebook/",
            parameters: [
                "access_token": fb_access_token
            ]
            )
            .response(
                 queue: DispatchQueue.main,
                 responseSerializer: DataRequest.jsonResponseSerializer(),
                 completionHandler: { (response) in
                     var responseJSON: JSON
                     if response.result.isFailure {
                         responseJSON = JSON.null
                     } else {
                         responseJSON = SwiftyJSON.JSON(response.result.value!)
                     }
                     DispatchQueue.main.async {
                       handler(responseJSON)
                     }
                 }
             )
    }

    func getUser(_ user_id: Int, handler: @escaping (JSON) -> Void) {
        print("Shout.swift -- Getting User")
        self.manager.request("\(Shout.host)/api/get_user",
            parameters: [
                "user_id": user_id
            ]
            )
            .response(
                 queue: DispatchQueue.main,
                 responseSerializer: DataRequest.jsonResponseSerializer(),
                 completionHandler: { (response) in
                     var responseJSON: JSON
                     if response.result.isFailure {
                         responseJSON = JSON.null
                     } else {
                         responseJSON = SwiftyJSON.JSON(response.result.value!)
                     }
                     DispatchQueue.main.async {
                       handler(responseJSON)
                     }
                 }
             )
    }


    func resetPassword(_ user_email: String, handler: @escaping (JSON) -> Void) {
        print("Shout.swift -- Resetting password...")
        self.manager.request("\(Shout.host)/api/reset_password",
            parameters: [
                "user_email": user_email
            ]
            )
            .response(
                 queue: DispatchQueue.main,
                 responseSerializer: DataRequest.jsonResponseSerializer(),
                 completionHandler: { (response) in
                     var responseJSON: JSON
                     if response.result.isFailure {
                         responseJSON = JSON.null
                     } else {
                         responseJSON = SwiftyJSON.JSON(response.result.value!)
                     }
                     DispatchQueue.main.async {
                       handler(responseJSON)
                     }
                 }
             )
    }
//    func uploadImage(caseID: Int, image: UIImage, progressHandler: (Float) -> Void, handler: @escaping (JSON) -> Void) {
//        // create url request to send
//        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "\(Force.host)/api/create_message")!)
//        mutableURLRequest.HTTPMethod = Alamofire.Method.POST.rawValue
//        let boundaryConstant = "myRandomBoundary12345";
//        let contentType = "multipart/form-data;boundary="+boundaryConstant
//        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
//
//        // create upload data to send
//        let uploadData = NSMutableData()
//
//        // add image
//        forceDebugPrint("\n[Force.swift] Adding image...")
//        let landscapeImage = image
//        let portraitImage = UIImage(CGImage: landscapeImage.CGImage!, scale: 1.0, orientation: UIImageOrientation.Right)
//        forceDebugPrint(portraitImage)
//
//        let imageData = UIImageJPEGRepresentation(portraitImage, 0.9)
//
//        uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//        uploadData.appendData("Content-Disposition: form-data; name=\"image\"; filename=\"upload.jpg\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//        uploadData.appendData("Content-Type: image/jpg\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//        uploadData.appendData(imageData!)
//
//        let parameters: [String: AnyObject] = [
//            "case_id": caseID,
//            "body": ""
//        ]
//
//        // add parameters
//        for (key, value) in parameters {
//            uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//            uploadData.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
//        }
//        uploadData.appendData("\r\n--\(boundaryConstant)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//
//
//
//        self.manager.upload(
//            Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0,
//            data: uploadData
//            ).progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
//                //            print("\(totalBytesWritten) / \(totalBytesExpectedToWrite)")
//                let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//                progressHandler(progress)
//            }
//            .responseSwiftyJSON { (request, response, json, error) in
//                handler(json)
//        }
//    }
//
   func registerMobileId(_ id: String, handler: @escaping (JSON) -> Void) {
       self.manager.request("\(Shout.host)/api/register_mobile_id/", method: .post,
           parameters: [
               "key": 1,  // 1 == iOS, 2 == Android
               "value": id,
               ]
           )
           .response(
                queue: DispatchQueue.main,
                responseSerializer: DataRequest.jsonResponseSerializer(),
                completionHandler: { (response) in
                    var responseJSON: JSON
                    if response.result.isFailure {
                        responseJSON = JSON.null
                    } else {
                        responseJSON = SwiftyJSON.JSON(response.result.value!)
                    }
                    DispatchQueue.main.async {
                      handler(responseJSON)
                    }
                }
            )
   }


}
