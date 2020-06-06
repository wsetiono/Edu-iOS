//
//  LoginViewController.swift
//  Education
//
//  Created by William on 31/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit
import SwiftyJSON

import Foundation
import Alamofire

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    var isLoginSuccess : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func LoginClicked(_ sender: Any) {
        
        let parameters: [String: AnyObject] =
            ["Email" : txtEmail.text! as AnyObject,
             "Password" : txtPassword.text! as AnyObject]
                 

          Alamofire.request("http://192.168.0.9:5000/api/users/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
              .responseJSON { response in
               
                if(response.description.contains("failed") || response.description.contains("errors"))
                {
                    print ("login failed")
                }
                else
                {
                    //print (response.description)
                                    
                    if let result = response.result.value {
                        
                        self.isLoginSuccess = true

                        let JSON = result as! NSDictionary
                        
                        print(JSON)
                        
                        UserDefaults.standard.set(JSON.object(forKey: "Name"), forKey: "name")
                        UserDefaults.standard.set(JSON.object(forKey: "Email"), forKey: "email")
                        UserDefaults.standard.set(JSON.object(forKey: "Image"), forKey: "image")

                        self.performSegue(withIdentifier: "Login", sender: nil)

                        
                        
                    }
                    
                }
                
                print (self.isLoginSuccess)
                
                
            }
               
    }
         
     override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {

        if self.isLoginSuccess == false {
            return false
        }

        return true
    }
        
}
    
    
 
    
    

