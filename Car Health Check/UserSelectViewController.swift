//
//  UserSelectViewController.swift
//  Car Health Check
//
//  Created by Simon Wild on 18/02/2016.
//  Copyright © 2016 Simon Wild. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class UserSelectViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerUserSelect: UIPickerView!
    //var users = [String]();
    var users = [User]();
    
    class User {
        var name:String!;
        var id:Int!;
        var car_id:Int!; 
        
        // Constructor
        init(name: String, id: Int, car_id: Int) {
            self.name = name
            self.id = id
            self.car_id = car_id
        }
        
    }
    
    override func viewDidLoad() {
        // Connect data:
        self.pickerUserSelect.delegate = self
        self.pickerUserSelect.dataSource = self
        
        super.viewDidLoad()
        // Do any additionalsetup after loadin
        //the view, typically from a nib.
        
        
        let postEndpoint: String = "http://simon-wild.co.uk/data/car_health_check2.json"
        Alamofire.request(.GET, postEndpoint, encoding:.JSON)
        .responseJSON { response in
                if let json = response.result.value {
                    let users2 = json["users"] as! [AnyObject]!;
                    //print(users);
                    
                    for obj:AnyObject in users2 {
                        print(obj);
                        print(obj["first_name"]);
                        let name = obj["first_name"] as! String;
                        let id = obj["id"] as! Int;
                        let car_id = obj["car_id"] as! Int;
                        self.users.append(User(name: name, id: id, car_id: car_id));
                        self.pickerUserSelect.reloadAllComponents();
                    }
                }
            }
        
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let name = users[row].name;
        return name;
    }
    
    
    
    @IBAction func Go_Click(sender: AnyObject) {
        let selIndex = pickerUserSelect.selectedRowInComponent(0);
        let userID = users[selIndex].id;
        NSUserDefaults.standardUserDefaults().setObject(userID, forKey: "User_ID");
    }
    
    
    
}

