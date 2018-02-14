//
//  FormViewController.h
//  ProfileLoader
//
//  Created by whoami on 11/30/17.
//  Copyright © 2017 Mountain Viewer. All rights reserved.
//

#import "ViewController.h"

@interface FormViewController : ViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *fullnameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *currentWorkField;
@property (weak, nonatomic) IBOutlet UITextField *birthdateField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *linkedinButton;

@property (strong, nonatomic) NSString *resultURL;
@property (strong, nonatomic) NSString *userID;

@end
