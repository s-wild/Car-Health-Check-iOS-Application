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
    var users = ["User 1","User 2","User 3","User 1","User 2","User 3"]
    
    override func viewDidLoad() {
        print("test")
        // Connect data:
        self.pickerUserSelect.delegate = self
        self.pickerUserSelect.dataSource = self
        
        super.viewDidLoad()
        // Do any additionalsetup after loadin
        //the view, typically from a nib.
        
        let postEndpoint: String = "http://simon-wild.co.uk/data/car_health_check.json"
        Alamofire.request(.GET, postEndpoint)
            .responseJSON { response in
                if let JSON = response.result.value {
                    //let users = JSON["users"]
                    print(JSON)
                   // let dataArray = users as! NSArray;
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
        return users[row]
    }
    
}

