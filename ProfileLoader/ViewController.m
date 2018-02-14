//
//  ViewController.m
//  ProfileLoader
//
//  Created by whoami on 11/30/17.
//  Copyright © 2017 Mountain Viewer. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()

@property (nonatomic, strong) FBSDKLoginButton *loginButton;
@property (nonatomic) BOOL loggedIn;

@end

@implementation ViewController

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (!error) {
        self.loggedIn = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.loggedIn) {
        [self performSegueWithIdentifier:@"login" sender:self];
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}

- (void)configureLoginButton {
    self.loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.loginButton.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 80);
    self.loginButton.delegate = self;
    // user_location and user_work_history and user_birthday is needed to approve
    self.loginButton.readPermissions = @[@"email", @"public_profile"];
    [self.view addSubview:self.loginButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loggedIn = NO;
    
    [self configureLoginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
