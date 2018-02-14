//
//  FormViewController.m
//  ProfileLoader
//
//  Created by whoami on 11/30/17.
//  Copyright © 2017 Mountain Viewer. All rights reserved.
//

#import "FormViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "UserViewController.h"
#import <SafariServices/SafariServices.h>
#import "WebViewController.h"
#import "ImageViewController.h"

@interface FormViewController ()

@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSString *requestedURL;
@property (nonatomic, strong) NSString *photoURL;

@end

@implementation FormViewController

- (IBAction)searchButtonTapped:(id)sender {
    /*NSDictionary *parameters = @{@"type" : @"user", @"q" : self.fullnameField.text};
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/search" parameters:parameters]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"Response: %@", result);
                 self.users = result[@"data"];
                 [self performSegueWithIdentifier:@"users" sender:self];
             }
         }];
    }*/
    
    NSString *formattedFullname = [self.fullnameField.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    
    self.requestedURL = [NSString stringWithFormat:@"https://www.facebook.com/search/people/?q=%@", formattedFullname];
    [self performSegueWithIdentifier:@"web" sender:self];
}

- (IBAction)linkedinButtonTapped:(id)sender {
    /*NSString *formattedFullname = [self.fullnameField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *webAddress = [NSString stringWithFormat:@"https://www.google.com/search?q=%@+site:linkedin.com", formattedFullname];
    NSURL *url = [[NSURL alloc] initWithString:webAddress];
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:url];
    [self presentViewController:vc animated:YES completion:nil]; */
    
    
    // Via LinkedIn directly
    NSString *formattedFullname = [self.fullnameField.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    self.requestedURL = [NSString stringWithFormat:@"https://www.linkedin.com/search/results/index/?keywords=%@", formattedFullname];
    [self performSegueWithIdentifier:@"web" sender:self];
    
    
    // Via Google
    /* NSString *formattedFullname = [self.fullnameField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    self.requestedURL = [NSString stringWithFormat:@"https://www.google.com/search?q=%@+site:linkedin.com", formattedFullname];
    [self performSegueWithIdentifier:@"web" sender:self]; */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"users"]) {
        UserViewController *vc = (UserViewController *)segue.destinationViewController;
        vc.users = self.users;
    } else if ([segue.identifier isEqualToString:@"web"]) {
        WebViewController *destVC = (WebViewController *)segue.destinationViewController;
        destVC.initialURL = self.requestedURL;
    } else if ([segue.identifier isEqualToString:@"image"]) {
        ImageViewController *destVC = (ImageViewController *)segue.destinationViewController;
        destVC.url = self.photoURL;
    }
}

- (void)configureSearchButton {
    self.searchButton.layer.borderColor = [UIColor colorWithRed:196.0/255.0 green:19.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
    self.searchButton.layer.borderWidth = 3.0;
    self.searchButton.layer.cornerRadius = 10.0;
}

- (void)configureLinkedinButton {
    self.linkedinButton.layer.borderColor = [UIColor colorWithRed:196.0/255.0 green:19.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
    self.linkedinButton.layer.borderWidth = 3.0;
    self.linkedinButton.layer.cornerRadius = 10.0;
}

- (void)assignDelegates {
    self.phoneNumberField.delegate = self;
    self.fullnameField.delegate = self;
    self.emailField.delegate = self;
    self.currentWorkField.delegate = self;
    self.locationField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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

- (void)viewDidAppear:(BOOL)animated {
    
    if (self.resultURL) {
        NSLog(@"I'm HERE");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You've got a new contact!" message:[NSString stringWithFormat:@"Your new contact is %@, the Facebook userID is %@", [[self.resultURL componentsSeparatedByString:@"?"] objectAtIndex:0], self.userID] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *loadAction = [UIAlertAction actionWithTitle:@"Load basic info" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSDictionary *parameters = @{@"fields" : @"name,age_range,email,work"};
            NSString *graphPath = [NSString stringWithFormat:@"/%@", self.userID];
            
            if ([FBSDKAccessToken currentAccessToken]) {
                NSString *path = [NSString stringWithFormat:@"/%@", self.userID];
                NSDictionary *parameters = @{@"fields" : @"picture.type(large)"};
                
                [[[FBSDKGraphRequest alloc] initWithGraphPath:path parameters:parameters]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         // NSLog(@"Response: %@", result);
                         NSLog(@"Result: %@", result[@"picture"][@"data"][@"url"]);
                         self.photoURL = result[@"picture"][@"data"][@"url"];
                         [self performSegueWithIdentifier:@"image" sender:self];
                         // [self.profileImageURLs addObject:[NSURL URLWithString:result[@"picture"][@"data"][@"url"]]];
                     }
                 }];
            }
            
            if ([FBSDKAccessToken currentAccessToken]) {
                [[[FBSDKGraphRequest alloc] initWithGraphPath:graphPath parameters:parameters]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         NSLog(@"Response: %@", result);
                     }
                 }];
            }
        }];
        
        
        [alertController addAction:okAction];
        [alertController addAction:loadAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithReadPermissions:@[@"email", @"public_profile"]
                        fromViewController:self
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                       //TODO: process error or result
                                   }];
    
    
    [self configureSearchButton];
    [self configureLinkedinButton];
    
    [self assignDelegates];
    [self removeLogOutButton];
}

@end
