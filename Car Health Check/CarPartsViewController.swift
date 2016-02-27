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
        var indent_value:Int!;
        
        init(name:String, value:String, indent_value:Int) {
            self.name = name;
            self.value = value;
            self.indent_value = indent_value;
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
                let car_model_capitalized = car_model.capitalizedString;
                let car_brand = carObj["brand"] as! String!;
                let car_brand_capitalized = car_brand.capitalizedString;
                let car_year = carObj["year"] as! String!;
                let last_mot = carObj["last_mot"] as! String!;
                let mot_due = carObj["mot_due"] as! String!;
                let last_service = carObj["last_service"] as! String!;
                
                // Get parts
                //let fl_brake = carObj["parts"][0]
                
                
               // let car_parts = carObj["parts"] as! [AnyObject]!;
                self.carName.text = car_model_capitalized + " " + car_brand_capitalized;
                
                // Add rows to table.
                //let car_year = carObj["year"] as! String!;
                print("--------------")
                print(car_model);
                print(car_brand);
                // Create objects
                carDetails = [];
                carDetails.append(Details(name: "Model", value: car_model_capitalized, indent_value: 0));
                carDetails.append(Details(name: "Brand", value: car_brand_capitalized, indent_value: 0));
                carDetails.append(Details(name: "Year", value: car_year, indent_value: 0));
                carDetails.append(Details(name: "Last MOT", value: last_mot, indent_value: 0));
                carDetails.append(Details(name: "MOT Due", value: mot_due, indent_value: 0));
                carDetails.append(Details(name: "Last Service", value: last_service, indent_value: 0));
                carDetails.append(Details(name: "Parts", value: "", indent_value: 0));
                appendDetailsForParts(carObj["parts"] as! [AnyObject]);
                
            }
        }
        

        
        //print(userID);
        super.viewDidLoad()
        // Do any additionalsetup after loadin
        //the view, typically from a nib.
        
    }
    
    func appendDetailsForParts(partsObj:[AnyObject]) {
        for part:AnyObject in partsObj {
            let name = part["name"] as! String;
            let nameFormatted = name.stringByReplacingOccurrencesOfString("_", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
            let nameFormattedCapital = nameFormatted.capitalizedString;
            let brand = part["brand"] as! String;
            let age = part["age"] as! String;
            let miles_used = part["miles_used"] as! String;
            let status = part["status"] as! String;
            let estimated_health_percentage_int = part["estimated_health_percentage"] as! Int;
            let estimated_health_percentage_string = String(estimated_health_percentage_int);
            
            // Append details to CarDetails class.
            carDetails.append(Details(name: "DO NOT SHOW", value: nameFormattedCapital, indent_value: 1));
            carDetails.append(Details(name: "Brand", value: brand, indent_value: 2));
            carDetails.append(Details(name: "Age", value: age, indent_value: 2));
            carDetails.append(Details(name: "Miles Used", value: miles_used, indent_value: 2));
            carDetails.append(Details(name: "Status", value: status, indent_value: 2));
            carDetails.append(Details(name: "Est Health", value: estimated_health_percentage_string, indent_value: 2));
        }
    }
    
    
    
    // Table View Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return carDetails.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCellLabel", forIndexPath: indexPath);
        let detail = carDetails[indexPath.item];
        // print(detail.value!);
        var text = "\(detail.name) \(": ") \(detail.value!)";
        
        if(detail.name == "DO NOT SHOW") {
            text = "\(detail.value!)";
        }
        if (detail.indent_value == 1) {
            cell.indentationLevel = 1;
            cell.indentationWidth = 5.0;
        }
        else if (detail.indent_value == 2) {
            cell.indentationLevel = 2;
            cell.indentationWidth = 9.0;
        }
        else {
            cell.indentationLevel = 0;
            cell.indentationWidth = 0;
        }
        
        cell.textLabel?.text = text;

        return cell;
    }

    
    
    
    
}