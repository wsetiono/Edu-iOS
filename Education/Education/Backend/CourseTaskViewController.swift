//
//  CourseTaskTableViewController.swift
//  Education
//
//  Created by William on 31/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit
import SwiftyJSON

import Foundation
import Alamofire

class CourseTaskViewController: UIViewController {

    var course: Course?
    var courseTasks = [CourseTask]()
    
    @IBOutlet weak var lbCourseName: UILabel!
    @IBOutlet weak var lbCourseContent: UILabel!
    @IBOutlet weak var lbCoursePrice: UILabel!
    @IBOutlet weak var lbCourseImage: UIImageView!
    
    @IBOutlet weak var tblCourseTask: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let courseName = course?.name {
            lbCourseName.text = course?.name
            lbCourseContent.text = course?.content
           
            //It won't work because it will print optional
            //lbCoursePrice.text = "\(String(describing: course!.price))" //convert int to string

            //Use this instead
            if let price = course?.price {
             // price is an Int
                lbCoursePrice.text = "Rp " + String(price)
            }
            
           
            
            if let logoName = course?.picture {
                   let url = "\(logoName)"
                //print("URL IMAGE : " + url)
                loadImage(imageView: lbCourseImage, urlString: url)
                
               
                
           }
                   
            
        }
        
        loadCourseTasks()
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
      
    
    func loadCourseTasks() {
        print("loadCourseTasks")
        
        if let courseId = course?.id
        {
            
        
           //API to get Course Task List
//                        Alamofire.request("http://192.168.0.9:5000/api/projects/task/8", method: .get, parameters: nil, encoding: URLEncoding(), headers: nil)
                
                        Alamofire.request("http://192.168.0.9:5000/api/projects/task/\(courseId)", method: .get, parameters: nil, encoding: URLEncoding(), headers: nil)
                            .responseJSON { response in
                         
                            switch response.result {
                                
                            case .success(let value):
                                let jsonData = JSON(value)
                                print(jsonData)
                                
//                                self.courses = []
//                                if let listCourse = jsonData["courses"].array {
//                                   for item in listCourse {
//                                       let course = Course(json: item)
//                                       self.courses.append(course)
//                                   }
                                
                                if jsonData != nil {
                                    self.courseTasks = []
                                    
                                    if let tempCourseTasks = jsonData["projectTask"].array {
                                        for item in tempCourseTasks {
                                            let courseTask = CourseTask(json: item)
                                            self.courseTasks.append(courseTask)
                                        }
                                        
                                        self.tblCourseTask.reloadData()
                                    }
                                }
                                   
                                   //TESTING
           //                        for c in self.courses {
           //                            print(c.name)
           //                            print(c.content)
           //                            print(c.price)
           //                            print(c.picture)
           //                        }
                                   
                                   //self.tblCourse.reloadData()
                                   
                                //}
                                
                                break
                                
                            case .failure:
                                break
                                
                            }
                            
                              
                          }
                    
                        //API to get Course List
            }
       }
 
    
}

    extension CourseTaskViewController: UITableViewDelegate, UITableViewDataSource {

        func numberOfSections(in tableView: UITableView) -> Int {
            1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return courseTasks.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CourseTaskCell", for: indexPath) as! CourseTaskViewCell
            
            let courseTask = courseTasks[indexPath.row]
            cell.lbCourseTaskNote.text = courseTask.note!
            cell.lbCourseTaskTitle.text = courseTask.title!
                        
            return cell
        }
    
    
}
