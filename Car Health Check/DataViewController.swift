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
        print("helloooo world")
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

