//
//  CarPartsViewController.swift
//  Car Health Check
//
//  Created by Simon Wild on 16/02/2016.
//  Copyright © 2016 Simon Wild. All rights reserved.
//

import UIKit


class CarPartsViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    @IBAction func swipeGesture(sender: AnyObject) {
//        
//        //self.navigationController.popToRootViewControllerAnimated(true)
//    }
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var carDetails = [Details]!();
    
    class Details{
        var name:String!;
        var value:String!;
        
        init(name:String, value:String) {
            self.name = name;
            self.value = value;
        }
    }
    
    override func viewDidLoad() {
        // Get User ID
        let userID = NSUserDefaults.standardUserDefaults().objectForKey("User_ID") as! Int;
        
        var car_id:Int!;
        var carObj:AnyObject;
        var car_model:String!;
        var car_brand:String!;
        var car_brand_model:String!;
        var car_year:String!;
        
        
        
        
        print("user ID");
        print(userID);
        
        // Get Car ID
        for user:AnyObject in Helper.users {
            let id = user["id"] as! Int;
            if (id == userID) {
                car_id = user["car_id"] as! Int;
                

            }
        }
        
        // Get car object
        for car:AnyObject in Helper.cars {
            //print(car["id"]);
            let id = car["id"] as! Int;
            if (id == car_id) {
                carObj = car;
                
                // Set Title Name (Car + Brand)
                let car_model = carObj["model"] as! String!;
                let car_brand = carObj["brand"] as! String!;
                let car_year = carObj["year"] as! String!;
                
               // let car_parts = carObj["parts"] as! [AnyObject]!;
                self.carName.text = car_brand + " " + car_model;
                
                // Add rows to table.
                //let car_year = carObj["year"] as! String!;
                print("--------------")
                print(car_model);
                print(car_brand);
                // Create objects
                carDetails = [];
                carDetails.append(Details(name: "Model", value: car_model));
                carDetails.append(Details(name: "Brand", value: car_brand));
                carDetails.append(Details(name: "Year", value: car_year));
                
            }
        }

        
        //print(userID);
        super.viewDidLoad()
        // Do any additionalsetup after loadin
        //the view, typically from a nib.
        
    }
    
    
    
    // Table View Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return carDetails.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCellLabel", forIndexPath: indexPath);
        let detail = carDetails[indexPath.item];
        let text = "\(detail.name) \(": ") \(detail.value)";
        //cell.textLabel?.text = carDetails[indexPath.item];
        cell.textLabel?.text = text;

        return cell;
    }

    
    
    
    
}