//
//  UserTableViewCell.h
//  ProfileLoader
//
//  Created by whoami on 11/30/17.
//  Copyright © 2017 Mountain Viewer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullname;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) UIViewController *vc;
@property (strong, nonatomic) NSString *userID;

@end
