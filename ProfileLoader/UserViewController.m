//
//  UserViewController.m
//  ProfileLoader
//
//  Created by whoami on 11/30/17.
//  Copyright © 2017 Mountain Viewer. All rights reserved.
//

#import "UserViewController.h"
#import "UserTableViewCell.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserViewController ()

@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (strong, nonatomic) NSMutableArray<NSURL*> *profileImageURLs;

@end

@implementation UserViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    
    UserTableViewCell *cell = (UserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (self.profileImageURLs.count == 0) {
        return cell;
    }
    
    [cell.imageView sd_setImageWithURL:self.profileImageURLs[indexPath.row]
                      placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.fullname.text = self.users[indexPath.row][@"name"];
    cell.userID = self.users[indexPath.row][@"id"];
    cell.button.layer.borderColor = [UIColor colorWithRed:196.0/255.0 green:19.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
    cell.button.layer.borderWidth = 2.0;
    cell.vc = self;
    
    return cell;
}

- (void)removeLogOutButton {
    UIView *viewToDelete = nil;
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[FBSDKLoginButton class]]) {
            viewToDelete = view;
            break;
        }
    }
    
    [viewToDelete removeFromSuperview];
}

- (void)loadProfileImages {
    self.profileImageURLs = [NSMutableArray array];
    __block int counter = 0;
    
    for (int i = 0; i < self.users.count; ++i) {
        if ([FBSDKAccessToken currentAccessToken]) {
            NSString *path = [NSString stringWithFormat:@"/%@", self.users[i][@"id"]];
            NSDictionary *parameters = @{@"fields" : @"picture.type(large)"};
            
            [[[FBSDKGraphRequest alloc] initWithGraphPath:path parameters:parameters]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     NSLog(@"Response: %@", result);
                     [self.profileImageURLs addObject:[NSURL URLWithString:result[@"picture"][@"data"][@"url"]]];
                 }
                 
                 counter += 1;
                 
                 if (counter == self.users.count) {
                     [self.userTableView reloadData];
                 }
             }];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self removeLogOutButton];
    [self loadProfileImages];
    
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    [self loadProfileImages];
}

@end
