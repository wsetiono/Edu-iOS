//
//  ViewController.swift
//  Education
//
//  Created by William on 30/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var btnLogin: UIButton!
    
    var buttonLoginText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        if (( UserDefaults.standard.string(forKey: "name")) != nil)
        {

         

            buttonLoginText = "Continue as " + ( UserDefaults.standard.string(forKey: "name")!)

        }
        else
        {
            buttonLoginText = "Login"
            //print("Login")
            
            //self.performSegue(withIdentifier: "homeScreenToLoginScreen", sender: self)

            
        }
        
btnLogin.setTitle(buttonLoginText, for: .normal)
      
    }

    @IBAction func LoginButtonClicked(_ sender: Any) {
        
        
        if (( UserDefaults.standard.string(forKey: "name")) != nil)
               {

                self.performSegue(withIdentifier: "homeScreenToCourseScreen", sender: self)

               }
               else
               {
                   
                   self.performSegue(withIdentifier: "homeScreenToLoginScreen", sender: self)

                   
               }
        
        
    }
    
    @IBAction func SignupButtonClicked(_ sender: Any) {
        
         self.performSegue(withIdentifier: "homeScreenToSignupScreen", sender: self)
        
    }
}
