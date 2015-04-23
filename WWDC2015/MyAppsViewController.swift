//
//  MyAppsViewController.swift
//  WWDC2015
//
//  Created by Ben Honig on 4/19/15.
//  Copyright (c) 2015 iPhonig, LLC. All rights reserved.
//

import UIKit

class MyAppsViewController: UIViewController {

    var appButtonXPadding = 40
    var appButtonHorizontalSpacing = 55
    var appButtonVeritcalPadding = 47
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup()
    }
    
    //set up
    func setup(){
        //create array of dictionary for app name and icon
        var arrayOfDictApps: NSArray = [["appName":"Poke Quiz","appIcon":"pokequiz"],
            ["appName":"Doggy Bounce","appIcon":"doggybounce"],
            ["appName":"iRon Dome","appIcon":"irondome"],
            ["appName":"PicMeme","appIcon":"picmeme"]]
        
        //iterate through arrayOfDictApps
        let numberOfButtons = arrayOfDictApps.count;
        //check to see if numberOfButtons is divisible by 2 because the button grid is 2 by Y
        var oldY = numberOfButtons % 3
        var newY = 0;
        if (oldY == 0){
            //divisible by 2 so successfully divide to get number of rows
            newY = numberOfButtons / 2;
        }else{
            //not divisible
            newY = (numberOfButtons / 2) + 1;//plus one becuase we need another row
        }
        for (var y = 0; y < newY; ++y) {
            for (var x = 0; x < 2; ++x) {
//                let appButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
//                appButton.frame = CGRectMake(40 + (95 * x), 95 * y, 120, 120)
//                //appButton.setTitle("\(appName)", forState: UIControlState.Normal);
//                appButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside);
//                appButton.backgroundColor = UIColor.redColor()
//                self.view.addSubview(appButton);

            }
        }
//        for app in arrayOfDictApps {
//            var appName = app["appName"]
//            var appIcon = app["appIcon"]
//            //create button
//            for var x = 0; x < 2; ++x{
//                let appButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
//                appButton.frame = CGRectMake(40, 47, 120, 120)
//                appButton.setTitle("\(appName)", forState: UIControlState.Normal);
//                appButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside);
//                appButton.backgroundColor = UIColor.redColor()
//                self.view.addSubview(appButton);
//            }
//            
//        }
    }
    
    func pressed(sender: UIButton!) {
        //show info about the app by first creating a uiview that blurs everything behind it, then create a separate view for the info about the app which will contain a picture and short description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
