//
//  DataViewController.swift
//  Car Health Check
//
//  Created by Simon Wild on 11/02/2016.
//  Copyright © 2016 Simon Wild. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    var fade = 0
    var updateTimer:NSTimer!;
    var dataObject: String = ""
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var frontBrake: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additionalsetup after loadin 
        //the view, typically from a nib.
        view.bringSubviewToFront(frontBrake)
        frontBrake.layer.cornerRadius = 16
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "callFunction", userInfo: nil, repeats: true)
        
        //var front_brake_right = false;
        //var front_brake_left = false;
        // front_brake_right value.
        // front_brake_left value.
        // Get shock_absorber.
        // Get catalytic_converter.
        
        // Get User ID
        let userID = NSUserDefaults.standardUserDefaults().objectForKey("User_ID") as! Int;
        //print(userID);
        
        var car_id:Int!;
        var carObj:AnyObject;
        
        //print(Helper.users);
        
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
//                print(carObj);
                // Get Front Brake.
                let parts = carObj["parts"] as! [AnyObject]!;
//                print(parts);
                
                var shock_absorber:AnyObject?;
                var front_left_brake:AnyObject?;
                var front_right_brake:AnyObject?;
                var cata_converter:AnyObject?;

                
                for p:AnyObject in parts {
                    let name = p["name"] as! String;
                    if (name == "shock_absorber") {
                        shock_absorber = p;
                    }
                    else if(name == "front_brake_left") {
                        front_left_brake = p;
                    }
                    else if(name == "front_brake_right") {
                        front_right_brake = p;
                    } else {
                        cata_converter = p;
                    }
                    
                  //  print("---PARTS START");
                    
//                    print(front_left_brake);
//                    print(front_right_brake);
//                    print(cata_converter);
                   // print("PARTS END---");
                    
                }
                let shock_absorber_health = shock_absorber!["estimated_health_percentage"];
                print("estimated_health_percentage");
                print(shock_absorber_health);
                
                
                let front_brake_left = front_left_brake!["front_brake_left"];
                print("front_brake_left");
                print(front_left_brake!["estimated_health_percentage"]);
                
                let front_brake_right = front_left_brake!["front_brake_right"];
                print("front_brake_right");
                print(front_right_brake!["estimated_health_percentage"]);
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }

    @IBAction func frontBrake_Click(sender: AnyObject) {
        print("helloooo world");
        
    }
    
    // Timer function
    func callFunction(){
        
        UIView.animateWithDuration(2.0, animations: {
            if (self.fade == 0) {
                self.frontBrake.alpha = 0.3
                self.fade = 1
            }
            else {
               self.frontBrake.alpha = 1
                self.fade = 0
            }
            
        })
    }
    

}

