//
//  CourseViewController.swift
//  Education
//
//  Created by William on 31/05/20.
//  Copyright © 2020 William. All rights reserved.
//


import UIKit
import SwiftyJSON

import Foundation
import Alamofire

class CourseViewController: UIViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var tblCourse: UITableView!
    
    
    var courses = [Course]() //array of Course Object
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
            
        loadCourses()
     
    }
    
    func loadCourses() {
        print("loadCourses")
        //API to get Course List
                     //Alamofire.request("http://192.168.0.9:5000/api/projects", method: .get, parameters: nil, encoding: JSONEncoding.default)
                     Alamofire.request("http://192.168.0.9:5000/api/projects", method: .get, parameters: nil, encoding: URLEncoding(), headers: nil)
                             
                         .responseJSON { response in
                      
                         switch response.result {
                             
                         case .success(let value):
                             let jsonData = JSON(value)
                             print(jsonData)
                             
                             self.courses = []
                             if let listCourse = jsonData["courses"].array {
                                for item in listCourse {
                                    let course = Course(json: item)
                                    self.courses.append(course)
                                }
                                
                                //TESTING
        //                        for c in self.courses {
        //                            print(c.name)
        //                            print(c.content)
        //                            print(c.price)
        //                            print(c.picture)
        //                        }
                                
                                self.tblCourse.reloadData()
                                
                             }
                             
                             break
                             
                         case .failure:
                             break
                             
                         }
                         
                           
                       }
                 
                     //API to get Course List
    }
    
    func loadImage(imageView: UIImageView, urlString: String) {
        let imgURL: URL = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: imgURL) { (data, response, error) in
            
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async(execute: {
                imageView.image = UIImage(data: data)
            })
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CourseTaskList" {
            let controller = segue.destination as! CourseTaskViewController
            controller.course = courses[(tblCourse.indexPathForSelectedRow?.row)!]
        }
    }
    
}

extension CourseViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as!
        CourseViewCell
        
        let course: Course
        course = courses[indexPath.row]
        
        cell.lbCourseName.text = course.name!
        
        if let logoName = course.picture {
                let url = "\(logoName)"
            loadImage(imageView: cell.imgCourseLogo, urlString: url)
        }
        
        return cell
    }
    
    
}
