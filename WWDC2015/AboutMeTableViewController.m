//
//  AboutMeTableViewController.m
//  WWDC2015
//
//  Created by Ben Honig on 4/19/15.
//  Copyright (c) 2015 iPhonig, LLC. All rights reserved.
//

#import "AboutMeTableViewController.h"
#import "PopMenu.h"
#import "NSString+StoryboardIdentifiers.h"
#import "CustomTableViewCell.h"

#define kAnimationTime 0.4F
#define kAvenirLight @"Avenir-Light"
#define kAvenirMedium @"Avenir-Medium"


@interface AboutMeTableViewController ()

@property (nonatomic, strong) PopMenu *popMenu;
@property (nonatomic, strong) NSArray *funFactsArray;
@property (nonatomic, strong) CustomTableViewCell *customCell;
@property (nonatomic, strong) UIBlurEffect *blurEffect;
@property (nonatomic, strong) UIVisualEffectView *blurView;

@end

@implementation AboutMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //make profile photo circular
    self.profilePhoto.layer.cornerRadius = self.profilePhoto.frame.size.width / 2;
    self.profilePhoto.layer.masksToBounds = YES;
    self.profilePhoto.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profilePhoto.layer.borderWidth = 2.0F;
    
    //set nav controller attirbutes
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:74.0F/255.0F green:144.0F/255.0F blue:226.0F/255.0F alpha:1.0F]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,
                                    [UIFont fontWithName:kAvenirMedium size:18.0F],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    
    //set up facts array
    self.funFactsArray = @[
                      @[@"I started coding in Visual Basic in high school, then moved onto Java.", @"codingIcon"],
                      @[@"When the App Store was announced I taught myself Objective-C.", @"xcodeIcon"],
                      @[@"Played ice hockey from elementray school until the start of college.", @"hockeyIcon"],
                      @[@"I'm a senior at Syracuse University.", @"cuseIcon"],
                      @[@"I began playing the piano at five years old.", @"pianoIcon"],
                      @[@"Self taught guitarist.", @"guitarIcon"],
                      @[@"Jazz trumpet player and improvisation fanatic.", @"trumpetIcon"],
                      @[@"During second semester of my freshman year at 'Cuse I decided to teach myself how to produce electronic dance music using Logic Pro. I post my tracks to Soundcloud under the alias 'Kinnetix'.", @"edmIcon"],
                      @[@"Brother of Pi Kappa Alpha fraternity.", @"pikeIcon"],
                      @[@"My father is blind but he ski's so I became a blind ski instructor to ski with him.", @"skiIcon"],
                      @[@"Windsurfing enthusiast.", @"surfingIcon"],
                      @[@"Fluent in reading and writing hebrew.", @"hebrewIcon"]
                      ];
    
    //fade in views
    [self fadeoutBlurView];
}

#pragma mark - Fade out blur
- (void)fadeoutBlurView{
    //create blur view
    self.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:self.blurEffect];
    self.blurView.frame = self.view.bounds;
    [self.view addSubview:self.blurView];
    //now fade out the blur view
    [UIView animateWithDuration:kAnimationTime
                          delay:0.3F
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.blurView.alpha = 0.0F;
                     } completion:^(BOOL finished) {
                         //animate the wiggle in the table by reloading it
                         [self.tableView reloadData];
                     }];
}

#pragma mark - Show POP Menu
- (void)showMenu{
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:1];
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"My Apps" iconName:@"app_button" glowColor:[UIColor grayColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"My Music" iconName:@"music_button" glowColor:[UIColor colorWithRed:0.000 green:0.840 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"About Me" iconName:@"about_button" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    __weak typeof(self) weakSelf = self;
    
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
    }
    if (_popMenu.isShowed) {
        return;
    }
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        if ([selectedItem.title isEqualToString:@"My Apps"]) {
            UIViewController *aboutMeController = [weakSelf.storyboard instantiateViewControllerWithIdentifier:[NSString myAppsIdentifier]];
            
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:aboutMeController];
            navController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [weakSelf presentViewController:navController animated:YES completion:^{
                //
            }];
        }
        if ([selectedItem.title isEqualToString:@"My Music"]) {
            //go to soundcloud
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.soundcloud.com/kinnetixmusic"]];
        }
        if ([selectedItem.title isEqualToString:@"About Me"]) {
            //do nothing
        }
    };
    
    [_popMenu showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}

- (IBAction)showMenuAction:(id)sender{
    [self showMenu];
}

#pragma mark - wiggle image

-(void)wiggleImage:(UIImageView *)image reverseAnimation:(BOOL)reverse{
    if (!reverse) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position.x";
        animation.values = @[ @0, @8, @-8, @4, @0 ];
        animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
        animation.duration = 0.4;
        animation.additive = YES;
        [image.layer addAnimation:animation forKey:@"wiggle"];
    }else{
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position.x";
        animation.values = @[ @0, @-8, @8, @-4, @0 ];
        animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
        animation.duration = 0.4;
        animation.additive = YES;
        [image.layer addAnimation:animation forKey:@"wiggleReverse"];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.funFactsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.descriptionlabel.text = self.funFactsArray[indexPath.row][0];
    cell.iconImage.image = [UIImage imageNamed:self.funFactsArray[indexPath.row][1]];
    
    //animate image alternating by row
    if( [indexPath row] % 2)
        [self wiggleImage:cell.iconImage reverseAnimation:NO];
    else
        [self wiggleImage:cell.iconImage reverseAnimation:YES];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Calculate a height based on a cell
    if(!self.customCell) {
        self.customCell = [self.tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    }
    
    //set font size
    self.customCell.descriptionlabel.text = self.funFactsArray[indexPath.row][0];
    self.customCell.descriptionlabel.font = [UIFont fontWithName:kAvenirLight size:16.0F];
    
    // Layout the cell
    [self.customCell layoutIfNeeded];
    
    // Get the height for the cell
    
    CGFloat height = [self.customCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Padding of 1 point (cell separator)
    CGFloat separatorHeight = 1;
    
    return height + separatorHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
