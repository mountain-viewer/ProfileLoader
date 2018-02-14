//
//  UserTableViewCell.m
//  ProfileLoader
//
//  Created by whoami on 11/30/17.
//  Copyright © 2017 Mountain Viewer. All rights reserved.
//

#import "UserTableViewCell.h"
#import <SafariServices/SafariServices.h>



@implementation UserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)viewProfileButtonTapped:(id)sender {
    NSString *webAddress = [NSString stringWithFormat:@"https://www.facebook.com/%@", self.userID];
    NSURL *url = [[NSURL alloc] initWithString:webAddress];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
    [self.vc presentViewController:safariVC animated:YES completion:nil];
}

@end
