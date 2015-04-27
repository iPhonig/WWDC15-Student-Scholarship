//
//  MyAppsViewController.swift
//  WWDC2015
//
//  Created by Ben Honig on 4/19/15.
//  Copyright (c) 2015 iPhonig, LLC. All rights reserved.
//

import UIKit

class MyAppsViewController: UIViewController, UIDynamicAnimatorDelegate {
    //global variables
    var animator: UIDynamicAnimator!
    var snap: UISnapBehavior!
    var popMenu: PopMenu = PopMenu()
    @IBOutlet weak var menuButton: UIBarButtonItem?

    //create array of dictionary for app name and icon
    var arrayOfDictApps: NSArray = [["appName":"Poke Quiz","appIcon":"pokequizIcon",
        "xCenter":"100","yCenter":"160"],
        ["appName":"Doggy Bounce","appIcon":"doggyBounceIcon",
            "xCenter":"275","yCenter":"160"],
        ["appName":"iRon Dome","appIcon":"irondomeIcon",
            "xCenter":"100","yCenter":"327"],
        ["appName":"PicMeme","appIcon":"picmemeIcon",
            "xCenter":"275","yCenter":"327"]]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.translucent = false
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 18)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.delay(0.4, closure: { () -> () in
            self.setup()
        })
        
    }
    
    //MARK: Delay
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    //MARK: Setup
    func setup(){
        //add physics to view
        animator = UIDynamicAnimator(referenceView: view)
        animator.delegate = self
        //iterate through arrayOfDictApps
        let numberOfButtons = arrayOfDictApps.count;
        //check to see if numberOfButtons is divisible by 2 because the button grid is 2 by Y
        var oldY = numberOfButtons % 2
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
                let button   = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                //this line would create an auto 2 x Y view of the buttons
                //since I've included the centers of the buttons I want all the buttons moving dynamically from one spot
                //button.frame = CGRectMake(CGFloat(40 + (175 * x)), CGFloat(107 + (167 * y)), CGFloat(120), CGFloat(120));
                button.frame = CGRectMake(CGFloat(CGRectGetMidX(self.view.frame)), CGFloat(CGRectGetMaxY(self.view.frame) - 200), 120, 120)
                var buttonNumber = y * 2 + x + 1;
                button.tag = buttonNumber;
                buttonNumber -= 1;
                button.backgroundColor = UIColor.clearColor()
                var imageName = arrayOfDictApps[buttonNumber]["appIcon"] as? String
                let image = UIImage(named: imageName!)
                button.setImage(image, forState: UIControlState.Normal)
                button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
                button.layer.cornerRadius = button.frame.width/10
                button.layer.masksToBounds = true
                self.view.addSubview(button)
                
                //add snap point 
                var centerPoint:CGPoint = CGPoint()
                let xCenterString = arrayOfDictApps[buttonNumber]["xCenter"] as? String
                if let xFormatter = NSNumberFormatter().numberFromString(xCenterString!) {
                    let xCenter = CGFloat(xFormatter)
                    centerPoint.x = xCenter
                }
                let yCenterString = arrayOfDictApps[buttonNumber]["yCenter"] as? String
                if let yFormatter = NSNumberFormatter().numberFromString(yCenterString!) {
                    let yCenter = CGFloat(yFormatter)
                    centerPoint.y = yCenter
                }
                snap = UISnapBehavior(item: button, snapToPoint: centerPoint)
                animator.addBehavior(snap)
                if(animator == true){
                    animator.removeBehavior(snap)
                }
            }
        }
        //create footer label
        self.createFooterLabel()
    }
    
    //MARK: button action
    func buttonAction(sender:UIButton!){
        //show info about the app by first creating a uiview that blurs everything behind it, then create a separate view for the info about the app which will contain a picture and short description
        let buttonText = "App Store"
        let cancelText = "Dismiss"
        if(sender.tag == 1){
            var alertview = BHAlertView().show(self.navigationController!, title: "Poke Quiz", text: "A fun quiz game that allows Pokemon trainers to test their knowledge. Over 600,000 downloads!", buttonText: buttonText, cancelButtonText:cancelText, color: UIColor.whiteColor(), iconImage: nil)
            alertview.addAction(openPokeQuiz)
            
        }
        if(sender.tag == 2){
            var alertview = BHAlertView().show(self.navigationController!, title: "Doggy Bounce", text: "Takes playing with your dog to a new level! Snap a pic and create your own dog, then play with it in this addictive single tap game", buttonText: buttonText, cancelButtonText:cancelText, color: UIColor.whiteColor(), iconImage: nil)
            alertview.addAction(openDoggyBounce)
        }
        if(sender.tag == 3){
            var alertview = BHAlertView().show(self.navigationController!, title: "iRon Dome", text: "An app that I built in 4 days with WWDC scholar Arik Sosman. It warns the people of Israeli if rockets are being fired and where.", buttonText: buttonText, cancelButtonText:cancelText, color: UIColor.whiteColor(), iconImage: nil)
            alertview.addAction(openiRonDome)
        }
        if(sender.tag == 4){
            var alertview = BHAlertView().show(self.navigationController!, title: "PicMeme", text: "Here's a modal alert with descriptive text, an icon, custom fonts and a custom color", buttonText: buttonText, cancelButtonText:cancelText, color: UIColor.whiteColor(), iconImage: nil)
            alertview.addAction(openPicMeme)
        }
        

    }
    
    func openPokeQuiz() {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://bit.ly/PokeQuiziOS")!)
    }
    func openDoggyBounce() {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://bit.ly/DoggyBounceiOS")!)
    }
    func openiRonDome() {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://bit.ly/iRonDomeApp")!)
    }
    func openPicMeme() {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://bit.ly/PicMeme")!)
    }
    
    //MARK: showMenu
    @IBAction func showMenu(sender:UIBarButtonItem) {
        var items = NSMutableArray(capacity: 1)
        
        var menuItem: MenuItem = MenuItem(title: "My Apps", iconName: "app_button", glowColor: UIColor.grayColor(), index: 0)
        items.addObject(menuItem)
        
        menuItem = MenuItem(title: "My Music", iconName: "music_button", glowColor: UIColor.grayColor(), index: 0)
        items.addObject(menuItem)
        
        menuItem = MenuItem(title: "About Me", iconName: "about_button", glowColor: UIColor.grayColor(), index: 0)
        items.addObject(menuItem)
        
        if let menu = self.popMenu as PopMenu!{
            self.popMenu = PopMenu(frame: self.navigationController!.view.bounds, items: items as [AnyObject])
        }
        
        if(self.popMenu.isShowed){
            return;
        }
        
        self.popMenu.didSelectedItemCompletion = { (selectedItem: MenuItem!) in
            if let item = selectedItem as MenuItem!{
                if(item.title == "My Apps"){
                    //do nothing
                }
                if(item.title == "My Music"){
                    UIApplication.sharedApplication().openURL(NSURL(string: "http://soundcloud.com/kinnetixmusic")!)
                }
                if(item.title == "About Me"){
                    var aboutMeController = self.storyboard!.instantiateViewControllerWithIdentifier("aboutMe") as! UIViewController
                    let navController = UINavigationController(rootViewController: aboutMeController)
                    navController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                    self.presentViewController(navController, animated:true, completion: nil)
                }

            }
        }
        
        self.popMenu.showMenuAtView(self.view, startPoint: CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)), endPoint: CGPointMake(60, CGRectGetHeight(self.view.bounds)))
        
    }
    
    //MARK: create footer label
    func createFooterLabel(){
        //create footer label
        var footerLabel = UILabel(frame: CGRectMake(0, 0, 300, 200))
        footerLabel.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(self.view.frame) - 170)
        footerLabel.font = UIFont(name: "Avenir-Light", size: 22.0)
        footerLabel.textColor = UIColor.lightGrayColor()
        footerLabel.numberOfLines = 3
        footerLabel.textAlignment = NSTextAlignment.Center
        footerLabel.text = "I've got another 2 apps in the works, they should be out by the time WWDC rolls around!"
        footerLabel.alpha = 0.0
        self.view.addSubview(footerLabel)
        //start fade animation for label
        UIView.animateWithDuration(3.0, delay: 0.0, options: .Repeat | .Autoreverse, animations: { () -> Void in
            footerLabel.alpha = 0.0
            footerLabel.alpha = 1.0
            }) { (Bool) -> Void in
        }

    }
    
    //MARK: make buttons bounce
    func bounceButtons(){
        for view in self.view.subviews as! [UIView] {
            if let button = view as? UIButton{
                UIView.animateWithDuration(0.6, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut | .Repeat | .Autoreverse | .AllowUserInteraction, animations: { () -> Void in
                    button.transform = CGAffineTransformMakeScale(0.9, 0.9)
                }, completion: { (Bool) -> Void in
                    //
                    
                })
            }
        }
    }
    
    //MARK: UIDynamicAnimatorDelegate
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        animator.removeAllBehaviors()
        //bounce buttons
        self.bounceButtons()
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
