//
//  AboutMeTableViewController.h
//  WWDC2015
//
//  Created by Ben Honig on 4/19/15.
//  Copyright (c) 2015 iPhonig, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeTableViewController : UITableViewController <UINavigationControllerDelegate, UINavigationBarDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *profilePhoto;
@property (nonatomic, weak) IBOutlet UIImageView *coverPhoto;

- (IBAction)showMenuAction:(id)sender;

@end
