//
//  CustomTableViewCell.h
//  WWDC2015
//
//  Created by Ben Honig on 4/20/15.
//  Copyright (c) 2015 iPhonig, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *iconImage;
@property (nonatomic, weak) IBOutlet UILabel *descriptionlabel;


@end
