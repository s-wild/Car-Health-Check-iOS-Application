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
    @IBOutlet weak var shockAbsorberButton: UIButton!
    @IBOutlet weak var frontRightBrake: UIButton!
    @IBOutlet weak var frontLeftBrake: UIButton!
    @IBOutlet weak var rearLeftBrake: UIButton!
    @IBOutlet weak var rearRightBrake: UIButton!
    @IBOutlet weak var rearShockAbsorber: UIButton!
    @IBOutlet weak var rearLeftLight: UIButton!
    @IBOutlet weak var rearRightLight: UIButton!
    @IBOutlet weak var frontRightLight: UIButton!
    @IBOutlet weak var frontLeftLight: UIButton!
    @IBOutlet weak var catalyticConverter: UIButton!
    
    var parts = [UIButton]();   // To store all status buttons for parts

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additionalsetup after loadin
        //the view, typically from a nib.
        view.bringSubviewToFront(frontBrake)
        
        // Initialise parts array
        parts = [self.frontBrake, self.shockAbsorberButton ,self.frontRightBrake, self.frontLeftBrake, self.frontLeftBrake, self.rearLeftBrake, self.rearRightBrake, self.rearShockAbsorber, self.rearLeftLight, self.rearRightLight, self.frontRightLight, self.frontLeftLight, self.catalyticConverter];
        
        // Set corner radius's for buttons for parts.
        for part:UIButton in parts {
            part.layer.cornerRadius = 16;
        }
        
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "callFunction", userInfo: nil, repeats: true)
        
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

                let parts = carObj["parts"] as! [AnyObject]!;
                
                // Shock Absorbers
                var shock_absorber:AnyObject?;
                var rear_shock_absorber:AnyObject?;
                
                // Brakes
                var front_left_brake:AnyObject?;
                var front_right_brake:AnyObject?;
                var rear_left_brake:AnyObject?;
                var rear_right_brake:AnyObject?;
                
                // Lights
                var front_right_light:AnyObject?;
                var front_left_light:AnyObject?;
                var rear_left_light:AnyObject?;
                var rear_right_light:AnyObject?;
                
                var cata_converter:AnyObject?;
 
                for p:AnyObject in parts {
                    let name = p["name"] as! String;
                    print("++++");
                    print(name);
                    if (name == "shock_absorber") {
                        shock_absorber = p;
                    }
                    else if(name == "front_brake_left") {
                        front_left_brake = p;
                    }
                    else if(name == "front_brake_right") {
                        front_right_brake = p;
                    } 
                    else if(name == "rear_brake_left") {
                        rear_left_brake = p;
                    }
                    else if(name == "rear_brake_right") {
                        rear_right_brake = p;
                    }
                    else if(name == "front_right_light") {
                        front_right_light = p;
                    }
                    else if(name == "front_left_light") {
                        front_left_light = p;
                    }
                    else if(name == "rear_left_light") {
                        rear_left_light = p;
                    }
                    else if(name == "rear_right_light") {
                        rear_right_light = p;
                    }
                    else if(name == "rear_shock_absorber") {
                        rear_shock_absorber = p;
                    }
                    else if(name == "catalytic_converter") {
                        cata_converter = p;
                    }
                }
                
                // Set shock absorber health values.
                let shock_absorber_health = shock_absorber!["estimated_health_percentage"] as! Int;
                toggleShockAbsorber(shock_absorber_health);
                
                let rear_shock_absorber_health = rear_shock_absorber!["estimated_health_percentage"] as! Int;
                toggleRearShockAbsorber(rear_shock_absorber_health);
                
                // Set brake values.
                let front_brake_left_health = front_left_brake!["estimated_health_percentage"] as! Int;
                toggleFrontLeftBrake (front_brake_left_health);
                print("front_brake_left");
                print(front_brake_left_health);
                
                let front_brake_right_health = front_right_brake!["estimated_health_percentage"] as! Int;
                toggleFrontRightBrake(front_brake_right_health);
                print("front_brake_right");
                print(front_brake_right_health);
                
                let rear_brake_left_health = rear_left_brake!["estimated_health_percentage"] as! Int;
                toggleRearLeftBrake(front_brake_right_health);
                print("rear_brake_left_health");
                print(rear_brake_left_health);
                
                let rear_brake_right_health = rear_right_brake!["estimated_health_percentage"] as! Int;
                toggleRearRightBrake(rear_brake_right_health);
                print("rear_brake_right_health");
                print(rear_brake_right_health);
                
                // Lights value.
                let front_light_right_health = front_right_light!["estimated_health_percentage"] as! Int;
                toggleFrontRightLight(front_light_right_health);
                print("front_light_right_health");
                print(front_light_right_health);
                
                let front_light_left_health = front_left_light!["estimated_health_percentage"] as! Int;
                toggleFrontLeftLight(front_light_left_health);
                print("front_light_left_health");
                print(front_light_left_health);
                
                let rear_light_left_health = rear_left_light!["estimated_health_percentage"] as! Int;
                toggleRearLeftLight(rear_light_left_health);
                print("rear_light_left_health");
                print(rear_light_left_health);
                
                let rear_light_right_health = rear_right_light!["estimated_health_percentage"] as! Int;
                toggleRearRightLight(rear_light_right_health);
                print("rear_light_right_health");
                print(rear_light_right_health);
                
                // Catalytic Converter.
                let catalytic_converter_health = cata_converter!["estimated_health_percentage"] as! Int;
                toggleCataConverter(catalytic_converter_health);
                print("catalytic_converter_health");
                print(catalytic_converter_health);
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
        UIView.animateWithDuration(1.0, animations: {
        
            if (self.fade == 0) {
                for part:UIButton in self.parts {
                    // Check if hidden
                    if (!part.hidden) {
                        part.alpha = 0.3;
                    }
                }
                self.fade = 1
            }
            else {
                for part:UIButton in self.parts {
                    // Check if hidden
                    if (!part.hidden) {
                        part.alpha = 1;
                    }
                }
               self.fade = 0
            }
            
        })
    }
    
    // Set view for shock absorber
    func toggleShockAbsorber (shock_absorber_health:Int) {
        if (shock_absorber_health >= 70) {
            shockAbsorberButton.hidden = true;
        } else if (shock_absorber_health > 50 && shock_absorber_health <= 70) {
            shockAbsorberButton.hidden = false;
            shockAbsorberButton.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1);
            
        } else if (shock_absorber_health < 50) {
            shockAbsorberButton.hidden = false;
            shockAbsorberButton.backgroundColor = UIColor(red: 233, green: 0, blue: 0, alpha: 1);
        }
    }
    
    // Set view for rear shock absorber
    func toggleRearShockAbsorber (rear_shock_absorber_health:Int) {
        if (rear_shock_absorber_health >= 70) {
            rearShockAbsorber.hidden = true;
            
        } else if (rear_shock_absorber_health > 50 && rear_shock_absorber_health <= 70) {
            rearShockAbsorber.hidden = false;
            rearShockAbsorber.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1);
            
        } else if (rear_shock_absorber_health < 50) {
            rearShockAbsorber.hidden = false;
            rearShockAbsorber.backgroundColor = UIColor(red: 233, green: 0, blue: 0, alpha: 1);
        }
    }
    
    // Check Right Brake Values.
    func toggleFrontRightBrake(front_brake_right_health:Int) {
        if (front_brake_right_health >= 70) {
            frontRightBrake.hidden = true;
            
        } else if (front_brake_right_health > 50 && front_brake_right_health <= 70) {
            frontRightBrake.hidden = false;
            frontRightBrake.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1);
            
        } else if (front_brake_right_health < 50) {
            frontRightBrake.hidden = false;
            frontRightBrake.backgroundColor = UIColor(red: 233, green: 0, blue: 0, alpha: 1);
        }
    }
    // Front Left Brake
    func toggleFrontLeftBrake(front_brake_left_health:Int) {
        if (front_brake_left_health >= 70) {
            frontLeftBrake.hidden = true;
            
        } else if (front_brake_left_health > 50 && front_brake_left_health <= 70) {
            frontLeftBrake.hidden = false;
            frontLeftBrake.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1);
            
        } else if (front_brake_left_health < 50) {
            frontLeftBrake.hidden = false;
            frontLeftBrake.backgroundColor = UIColor(red: 233, green: 0, blue: 0, alpha: 1);
        }
    }
    // Rear Left Brake
    func toggleRearLeftBrake(rear_brake_left_health:Int) {
        if (rear_brake_left_health >= 70) {
            rearLeftBrake.hidden = true;
            
        } else if (rear_brake_left_health > 50 && rear_brake_left_health <= 70) {
            rearLeftBrake.hidden = false;
            rearLeftBrake.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1);
            
        } else if (rear_brake_left_health < 50) {
            rearLeftBrake.hidden = false;
            rearLeftBrake.backgroundColor = UIColor(red: 233, green: 0, blue: 0, alpha: 1);
        }
    }
    // Rear Right Brake
    func toggleRearRightBrake(rear_brake_right_health:Int) {
        if (rear_brake_right_health >= 70) {
            rearRightBrake.hidden = true;
            
        } else if (rear_brake_right_health > 50 && rear_brake_right_health <= 70) {
            rearRightBrake.hidden = false;
            rearRightBrake.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1);
            
        } else if (rear_brake_right_health < 50) {
            rearRightBrake.hidden = false;
            rearRightBrake.backgroundColor = UIColor(red: 233, green: 0, blue: 0, alpha: 1);
        }
    }
    // Front Right Light
    func toggleFrontRightLight(rear_brake_right_health:Int) {
        if (rear_brake_right_health >= 70) {
            frontRightLight.hidden = true;
            
        } else if (rear_brake_right_health > 50 && rear_brake_right_health <= 70) {
            frontRightLight.hidden = false;
            frontRightLight.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1);
            
        } else if (rear_brake_right_health < 50) {
            frontRightLight.hidden = false;
            frontRightLight.backgroundColor = UIColor(red: 233, green: 0, blue: 0, alpha: 1);
        }
    }
    // Front Left Light
    func toggleFrontLeftLight(front_light_left_health:Int) {
        if (front_light_left_health >= 70) {
            frontLeftLight.hidden = true;
            
        } else if (front_light_left_health > 50 && front_light_left_health <= 70) {
            frontLeftLight.hidden = false;
            frontLeftLight.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1);
            
        } else if (front_light_left_health < 50) {
            frontLeftLight.hidden = false;
            frontLeftLight.backgroundColor = UIColor(red: 233, green: 0, blue: 0, alpha: 1);
        }
    }
    // Rear Left Light
    func toggleRearLeftLight(rear_light_left_health:Int) {
        if (rear_light_left_health >= 70) {
            rearLeftLight.hidden = true;
            
        } else if (rear_light_left_health > 50 && rear_light_left_health <= 70) {
            rearLeftLight.hidden = false;
            rearLeftLight.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1);
            
        } else if (rear_light_left_health < 50) {
            rearLeftLight.hidden = false;
            rearLeftLight.backgroundColor = UIColor(red: 233, green: 0, blue: 0, alpha: 1);
        }
    }
    // Rear Left Light
    func toggleRearRightLight(rear_light_right_health:Int) {
        if (rear_light_right_health >= 70) {
            rearRightLight.hidden = true;
            
        } else if (rear_light_right_health > 50 && rear_light_right_health <= 70) {
            rearRightLight.hidden = false;
            rearRightLight.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1);
            
        } else if (rear_light_right_health < 50) {
            rearRightLight.hidden = false;
            rearRightLight.backgroundColor = UIColor(red: 233, green: 0, blue: 0, alpha: 1);
        }
    }
    
    // Rear Left Light
    func toggleCataConverter(catalytic_converter_health:Int) {
        print("++++++++++++ZZZZZZ");
        print(catalytic_converter_health);
        if (catalytic_converter_health >= 70) {
            catalyticConverter.hidden = true;
            
        } else if (catalytic_converter_health > 50 && catalytic_converter_health <= 70) {
            catalyticConverter.hidden = false;
            catalyticConverter.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1);
            
        } else if (catalytic_converter_health < 50) {
            catalyticConverter.hidden = false;
            catalyticConverter.backgroundColor = UIColor(red: 233, green: 0, blue: 0, alpha: 1);
        }
    }

}

