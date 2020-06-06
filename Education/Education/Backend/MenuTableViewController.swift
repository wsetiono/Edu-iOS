//
//  MenuTableViewController.swift
//  Education
//
//  Created by William on 31/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbName.text =  UserDefaults.standard.string(forKey: "name")

        imgAvatar.image = try! UIImage(data: Data(contentsOf: URL(string: UserDefaults.standard.string(forKey: "image")!)!))

        view.backgroundColor = UIColor(red: 0.19, green: 0.18, blue: 0.31, alpha: 1.0)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Logout" {
            UserDefaults.standard.removeObject(forKey: "name")
            UserDefaults.standard.removeObject(forKey: "image")
            UserDefaults.standard.removeObject(forKey: "email")
            //print("logout")
        }
        
    }
    
    

}
