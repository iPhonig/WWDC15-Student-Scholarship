//
//  MyMusicTableViewController.m
//  WWDC2015
//
//  Created by Ben Honig on 4/19/15.
//  Copyright (c) 2015 iPhonig, LLC. All rights reserved.
//

#import "MyMusicTableViewController.h"
#import "PopMenu.h"
#import "NSString+StoryboardIdentifiers.h"
#import "MyMusicTableViewController.h"
#import "AboutMeTableViewController.h"

@interface MyMusicTableViewController ()

@property (nonatomic, strong) PopMenu *popMenu;

@end

@implementation MyMusicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //set nav controller attirbutes
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:74.0F/255.0F green:144.0F/255.0F blue:226.0F/255.0F alpha:1.0F]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,
                                    [UIFont fontWithName:@"Avenir-Medium" size:18.0F],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
}

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
//            MyCustomViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyViewController"];
//            
//            [self presentViewController:vc animated:YES completion:nil];
        }
        if ([selectedItem.title isEqualToString:@"My Music"]) {
            
        }
        if ([selectedItem.title isEqualToString:@"About Me"]) {
            AboutMeTableViewController *aboutMe = [weakSelf.storyboard instantiateViewControllerWithIdentifier:[NSString aboutMeIdentifier]];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:aboutMe];
            navController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [weakSelf presentViewController:navController animated:YES completion:nil];
        }

    };
    
    //    [_popMenu showMenuAtView:self.view];
    
    [_popMenu showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}

- (IBAction)showMenuAction:(id)sender{
    [self showMenu];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
