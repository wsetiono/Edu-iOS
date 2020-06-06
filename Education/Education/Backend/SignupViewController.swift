//
//  SignupViewController.swift
//  Education
//
//  Created by William on 01/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit
import SwiftyJSON

import Foundation
import Alamofire


class SignupViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
     var isSignupSuccess : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func SignupClicked(_ sender: Any) {
        
        let parameters: [String: AnyObject] =
                  ["Name" : txtName.text! as AnyObject,
                   "Email" : txtEmail.text! as AnyObject,
                   "Password" : txtPassword.text! as AnyObject]
                       

                Alamofire.request("http://192.168.0.9:5000/api/users/register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                    .responseJSON { response in
                     
                      if(response.description.contains("failed") || response.description.contains("errors"))
                      {
                          print ("signup failed")
                      }
                      else
                      {
                          //print (response.description)
                                          
                          if let result = response.result.value {
                              
                              self.isSignupSuccess = true

                              let JSON = result as! NSDictionary
                              
                              print(JSON)
                              
                              UserDefaults.standard.set(JSON.object(forKey: "Name"), forKey: "name")
                              UserDefaults.standard.set(JSON.object(forKey: "Email"), forKey: "email")
                              UserDefaults.standard.set(JSON.object(forKey: "Image"), forKey: "image")

                              self.performSegue(withIdentifier: "Signup", sender: nil)

                              
                              
                          }
                          
                      }
                      
                      print (self.isSignupSuccess)
                      
                      
                  }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {

        if self.isSignupSuccess == false {
            return false
        }

        return true
    }
    
}
