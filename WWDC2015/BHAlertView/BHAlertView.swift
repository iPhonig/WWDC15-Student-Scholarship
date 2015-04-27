//
//  BHAlertView.swift
//  WWDC2015
//
//  Created by Ben Honig on 4/26/15.
//  Copyright (c) 2015 iPhonig, LLC. All rights reserved.
//

import Foundation
import UIKit

class BHAlertView: UIViewController {
    var containerView:UIView!
    var alertBackgroundView:UIView!
    var dismissButton:UIButton!
    var cancelButton:UIButton!
    var buttonLabel:UILabel!
    var cancelButtonLabel:UILabel!
    var titleLabel:UILabel!
    var textView:UITextView!
    var rootViewController:UIViewController!
    var iconImage:UIImage!
    var iconImageView:UIImageView!
    var closeAction:(()->Void)!
    var isAlertOpen:Bool = false

    var titleFont = "Avenir-Light"
    var textFont = "Avenir-Medium"
    var buttonFont = "Avenir-Book"
    
    var defaultColor = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1.0)
    var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
    
    let baseHeight:CGFloat = 160.0
    var alertWidth:CGFloat = 290.0
    let buttonHeight:CGFloat = 70.0
    let padding:CGFloat = 20.0
    
    var viewWidth:CGFloat?
    var viewHeight:CGFloat?
    
    enum BHAlertViewFontType {
        case Title, Text, Button
    }
    
    // Allow alerts to be closed/renamed in a chainable manner
    class BHAlertViewResponder {
        let alertview: BHAlertView
        
        init(alertview: BHAlertView) {
            self.alertview = alertview
        }
        
        func addAction(action: ()->Void) {
            self.alertview.addAction(action)
        }
        
        func setTitleFont(fontStr: String) {
            self.alertview.setFont(fontStr, type: .Title)
        }
        
        func close() {
            self.alertview.closeView(false)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let size = UIScreen.mainScreen().bounds.size
        self.viewWidth = size.width
        self.viewHeight = size.height
        
        var yPos:CGFloat = 0.0
        var contentWidth:CGFloat = self.alertWidth - (self.padding*2)
        
        // position the icon image view, if there is one
        if self.iconImageView != nil {
            yPos += iconImageView.frame.height
            var centerX = (self.alertWidth-self.iconImageView.frame.width)/2
            self.iconImageView.frame.origin = CGPoint(x: centerX, y: self.padding)
            yPos += padding
        }
        
        // position the title
        let titleString = titleLabel.text! as NSString
        let titleAttr = [NSFontAttributeName:titleLabel.font]
        let titleSize = CGSize(width: contentWidth, height: 90)
        let titleRect = titleString.boundingRectWithSize(titleSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: titleAttr, context: nil)
        yPos += padding
        self.titleLabel.frame = CGRect(x: self.padding, y: yPos, width: self.alertWidth - (self.padding*2), height: ceil(titleRect.size.height))
        yPos += ceil(titleRect.size.height)
        
        
        // position text
        if self.textView != nil {
            let textString = textView.text! as NSString
            let textAttr = [NSFontAttributeName:textView.font]
            let textSize = CGSize(width: contentWidth, height: 90)
            let textRect = textString.boundingRectWithSize(textSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textAttr, context: nil)
            self.textView.frame = CGRect(x: self.padding, y: yPos, width: self.alertWidth - (self.padding*2), height: ceil(textRect.size.height)*2)
            yPos += ceil(textRect.size.height) + padding/2
        }
        
        // position the buttons
        yPos += self.padding
        
        var buttonWidth = self.alertWidth
        if self.cancelButton != nil {
            buttonWidth = self.alertWidth/2
            self.cancelButton.frame = CGRect(x: 0, y: yPos, width: buttonWidth-0.5, height: self.buttonHeight)
            if self.cancelButtonLabel != nil {
                self.cancelButtonLabel.frame = CGRect(x: self.padding, y: (self.buttonHeight/2) - 15, width: buttonWidth - (self.padding*2), height: 30)
            }
        }
        
        var buttonX = buttonWidth == self.alertWidth ? 0 : buttonWidth
        self.dismissButton.frame = CGRect(x: buttonX, y: yPos, width: buttonWidth, height: self.buttonHeight)
        if self.buttonLabel != nil {
            self.buttonLabel.frame = CGRect(x: self.padding, y: (self.buttonHeight/2) - 15, width: buttonWidth - (self.padding*2), height: 30)
        }
        
        // set button fonts
        if self.buttonLabel != nil {
            buttonLabel.font = UIFont(name: self.buttonFont, size: 20)
        }
        if self.cancelButtonLabel != nil {
            cancelButtonLabel.font = UIFont(name: self.buttonFont, size: 20)
        }
        
        yPos += self.buttonHeight
        
        // size the background view
        self.alertBackgroundView.frame = CGRect(x: 0, y: 0, width: self.alertWidth, height: yPos)
        
        // size the container that holds everything together
        self.containerView.frame = CGRect(x: (self.viewWidth!-self.alertWidth)/2, y: (self.viewHeight! - yPos)/2, width: self.alertWidth, height: yPos)
        
    }

    func show(viewController: UIViewController, title: String, text: String?=nil, buttonText: String?=nil, cancelButtonText: String?=nil, color: UIColor?=nil, iconImage: UIImage?=nil) -> BHAlertViewResponder {
        
        self.rootViewController = viewController
        self.rootViewController.addChildViewController(self)
        self.rootViewController.view.addSubview(view)
        //add blur to background
        self.visualEffectView.frame = self.view.bounds
        
        self.view.addSubview(self.visualEffectView)
        
        self.view.backgroundColor = UIColor.clearColor()
        
        var textColor = UIColor.whiteColor()
        
        let sz = UIScreen.mainScreen().bounds.size
        self.viewWidth = sz.width
        self.viewHeight = sz.height
        
        // Container for the entire alert modal contents
        self.containerView = UIView()
        self.view.addSubview(self.containerView!)
        
        // Background view/main color
        self.alertBackgroundView = UIView()
        alertBackgroundView.backgroundColor = self.defaultColor
        alertBackgroundView.layer.cornerRadius = 4
        alertBackgroundView.layer.masksToBounds = true
        self.containerView.addSubview(alertBackgroundView!)
        
        // Icon
        self.iconImage = iconImage
        if self.iconImage != nil {
            self.iconImageView = UIImageView(image: self.iconImage)
            self.containerView.addSubview(iconImageView)
        }
        
        // Title
        self.titleLabel = UILabel()
        titleLabel.textColor = textColor
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont(name: self.titleFont, size: 24)
        titleLabel.text = title
        self.containerView.addSubview(titleLabel)
        
        // View text
        if let text = text {
            self.textView = UITextView()
            self.textView.userInteractionEnabled = false
            textView.editable = false
            textView.textColor = textColor
            textView.textAlignment = .Center
            textView.font = UIFont(name: self.textFont, size: 16)
            textView.backgroundColor = UIColor.clearColor()
            textView.text = text
            self.containerView.addSubview(textView)
        }
        
        // Button
        self.dismissButton = UIButton()
        let buttonColor = UIColor.whiteColor()
        let buttonHighlightColor = UIColor.whiteColor()
        if(dismissButton.state == UIControlState.Normal){
            dismissButton.backgroundColor = buttonColor
        }
        if(dismissButton.state == UIControlState.Highlighted){
            dismissButton.backgroundColor = buttonHighlightColor
        }
        dismissButton.addTarget(self, action: "buttonTap", forControlEvents: .TouchUpInside)
        alertBackgroundView!.addSubview(dismissButton)
        // Button text
        self.buttonLabel = UILabel()
        buttonLabel.textColor = self.defaultColor
        buttonLabel.numberOfLines = 1
        buttonLabel.textAlignment = .Center
        if let text = buttonText {
            buttonLabel.text = text
        } else {
            buttonLabel.text = "OK"
        }
        dismissButton.addSubview(buttonLabel)
        
        // Second cancel button
        if let btnText = cancelButtonText {
            self.cancelButton = UIButton()
            let cancelButtonColor = UIColor.whiteColor()
            let cancelButtonHighlightColor = UIColor.whiteColor()
            if(cancelButton.state == UIControlState.Normal){
                cancelButton.backgroundColor = buttonColor
            }
            if(cancelButton.state == UIControlState.Highlighted){
                cancelButton.backgroundColor = buttonHighlightColor
            }

            cancelButton.addTarget(self, action: "cancelButtonTap", forControlEvents: .TouchUpInside)
            alertBackgroundView!.addSubview(cancelButton)
            // Button text
            self.cancelButtonLabel = UILabel()
            cancelButtonLabel.alpha = 0.7
            
            cancelButtonLabel.numberOfLines = 1
            cancelButtonLabel.textAlignment = .Center
            if let text = cancelButtonText {
                cancelButtonLabel.text = text
            }
            
            cancelButton.addSubview(cancelButtonLabel)
        }
        
        // Animate it in
        self.view.alpha = 0
        UIView.animateWithDuration(0.2, animations: {
            self.view.alpha = 1
        })
        self.containerView.frame.origin.x = self.rootViewController.view.center.x
        self.containerView.center.y = -500
        UIView.animateWithDuration(0.5, delay: 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: {
            self.containerView.center = self.rootViewController.view.center
            }, completion: { finished in
                
        })
        
        isAlertOpen = true
        return BHAlertViewResponder(alertview: self)
    }
    
    func setFont(fontStr: String, type: BHAlertViewFontType) {
        switch type {
        case .Title:
            self.titleFont = fontStr
            if let font = UIFont(name: self.titleFont, size: 24) {
                self.titleLabel.font = font
            } else {
                self.titleLabel.font = UIFont.systemFontOfSize(24)
            }
        case .Text:
            if self.textView != nil {
                self.textFont = fontStr
                if let font = UIFont(name: self.textFont, size: 16) {
                    self.textView.font = font
                } else {
                    self.textView.font = UIFont.systemFontOfSize(16)
                }
            }
        case .Button:
            self.buttonFont = fontStr
            if let font = UIFont(name: self.buttonFont, size: 24) {
                self.buttonLabel.font = font
            } else {
                self.buttonLabel.font = UIFont.systemFontOfSize(24)
            }
        }
        // relayout to account for size changes
        self.viewDidLayoutSubviews()
    }
    
    func addAction(action: ()->Void) {
        self.closeAction = action
    }
    
    func buttonTap() {
        closeView(true);
    }
    
    func cancelButtonTap() {
        closeView(false);
    }
    
    func closeView(withCallback:Bool) {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: {
            self.containerView.center.y = self.rootViewController.view.center.y + self.viewHeight!
            }, completion: { finished in
                UIView.animateWithDuration(0.4, animations: {
                    self.view.alpha = 0
                    }, completion: { finished in
                        if withCallback == true {
                            if let action = self.closeAction {
                                action()
                            }
                        }
                        self.removeView()
                })
                
        })
    }
    
    func removeView() {
        isAlertOpen = false
        self.view.removeFromSuperview()
    }

}
