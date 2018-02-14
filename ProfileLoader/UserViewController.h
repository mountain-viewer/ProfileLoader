//
//  UserViewController.h
//  ProfileLoader
//
//  Created by whoami on 11/30/17.
//  Copyright © 2017 Mountain Viewer. All rights reserved.
//

#import "ViewController.h"

@interface UserViewController : ViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *users;

@end
