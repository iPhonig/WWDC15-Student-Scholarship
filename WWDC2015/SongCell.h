//
//  SongCell.h
//  WWDC2015
//
//  Created by Ben Honig on 4/26/15.
//  Copyright (c) 2015 iPhonig, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *iconImage;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *playPauseButton;

@end
